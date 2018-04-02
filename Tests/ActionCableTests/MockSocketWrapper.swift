//
//  MockSocketWrapper.swift
//  ActionCableTests
//
//  Created by Jeremy Greenwood on 3/12/18.
//

import Foundation
@testable import Hermes
@testable import ActionCable

struct MockSocketWrapper: WebSocketWrapper {
    func connect() {
        connectHandler?()
    }
    
    func disconnect() {
        disconnectHandler?(nil)
    }
    
    init(socket: WebSocket) {}
    
    var connectHandler: ConnectHandler?
    
    var disconnectHandler: DisconnectHandler?
    
    var dataHandler: DataHandler?
    
     func write(_ data: Data) {
        let channelName = "channelName"
        if let instruction = try? JSONDecoder().decode(Instruction.self, from: data) {
            switch instruction.command {
            case .subscribe:
                 let status = Status(type: .confirmation,  identifier: Identifier(channel: Channel(name: channelName)), data: data)
                dataHandler?(status.data)
            case .message:
                let instruction  = Instruction(command: .message, identifier: Identifier(channel: Channel(name: channelName)), data: data)
                dataHandler?(instruction.data!)
            default:
                break

        }
     }
 }
    

}
