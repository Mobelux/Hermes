//
//  Hermes.swift
//  Hermes
//
//  Created by Jeremy Greenwood on 3/8/18.
//  Copyright © 2018 Mobelux. All rights reserved.
//

import Foundation
import Starscream

public typealias ConnectHandler = () -> ()
public typealias DisconnectHandler = (Error?) -> ()
public typealias DataHandler = (Data) -> ()
public typealias TextHandler = (String) -> ()

public protocol WebSocketWrapper {
    init(socket: WebSocket?)

    var connectHandler: ConnectHandler? { get set }
    var disconnectHandler: DisconnectHandler? { get set }
    var dataHandler: DataHandler? { get set }
    var textHandler: TextHandler? { get set }

    func write(_ data: Data)
    func connect()
    func disconnect()
}

open class Hermes: WebSocketWrapper {
    public var socket: WebSocket?

    public required init(socket: WebSocket?) {
        self.socket = socket
    }

    public var connectHandler: ConnectHandler? {
        didSet {
            socket?.onConnect = connectHandler
        }
    }

    public var disconnectHandler: DisconnectHandler? {
        didSet {
            socket?.onDisconnect = disconnectHandler
        }
    }

    public var dataHandler: DataHandler? {
        didSet {
            socket?.onData = dataHandler
        }
    }

    public var textHandler: TextHandler? {
        didSet {
            socket?.onText = textHandler
        }
    }
}

public extension Hermes {
    func write(_ data: Data) {
        socket?.write(data: data)
    }

    func connect() {
        socket?.connect()
    }

    func disconnect() {
        socket?.disconnect()
    }
}
