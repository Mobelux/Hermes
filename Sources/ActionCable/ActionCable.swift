//
//  ActionCable.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation
import Hermes

public typealias SubscribedHandler = (Channel) -> ()
public typealias UnsubscribedHandler = (Channel) -> ()
public typealias RejectedHandler = () -> ()
public typealias InstructionHandler = (Instruction) -> ()

open class ActionCable<WebSocketType: WebSocket> {
    // MARK: - Internal
    var hermes: Hermes
    var channels: [String: Channel] = [:]
    var subscribedHandler: SubscribedHandler?
    var unsubscribedHandler: UnsubscribedHandler?

    // MARK: - Public
    public var token: String?
    public var rejectedHandler: RejectedHandler?
    public var instructionHandler: InstructionHandler?

    public init?(request: Request) {
        guard let socket = WebSocketType(request: request) else {
            return nil
        }

        hermes = Hermes(socket: socket)
        hermes.dataHandler = handle
    }
}

public extension ActionCable {
    func connect(handler: (() -> ())?) {
        hermes.connectHandler = handler
        hermes.connect()
    }

    func disconnect(handler: ((Error?) -> ())?) {
        hermes.disconnectHandler = handler
        hermes.disconnect()
    }

    func subscribe(_ channelName: String, handler: SubscribedHandler?) throws {
        subscribedHandler = handler
        try write(ActionCable.subscribeInstruction(channelName), to: hermes)
    }

    func unsubscribe(_ channelName: String) throws {
        channels.removeValue(forKey: channelName)

        try write(ActionCable.unsubscribeInstruction(channelName), to: hermes)
    }

    func send(_ instruction: Instruction) throws {
        try write(instruction, to: hermes)
    }
}

private extension ActionCable {
    func write(_ instruction: Instruction, to hermes: Hermes) throws {
        let data = try JSONEncoder().encode(instruction)
        hermes.write(data)
    }

    func handle(data: Data) {
        if let status: Status = object(data: data) {
            switch status.type {
            case .confirmation:
                channels[status.identifier.channel.name] = status.identifier.channel

                subscribedHandler?(status.identifier.channel)
                subscribedHandler = nil
            case .ping: break
            case .rejection:
                rejectedHandler?()
            case .welcome: break
            }
        } else if let instruction: Instruction = object(data: data) {
            instructionHandler?(instruction)
        } else {
            debugPrint("\(#function) - Invalid data structure")
        }
    }

    func object<T: Codable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    static func subscribeInstruction(_ channelName: String) -> Instruction {
        return Instruction(command: .subscribe, identifier: Identifier(channel: Channel(name: channelName)), data: nil)
    }

    static func unsubscribeInstruction(_ channelName: String) -> Instruction {
        return Instruction(command: .unsubscribe, identifier: Identifier(channel: Channel(name: channelName)), data: nil)
    }
}
