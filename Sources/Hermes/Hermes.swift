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

open class Hermes {
    internal var socket: WebSocket

    public init(socket: WebSocket) {
        self.socket = socket
    }

    public var connectHandler: ConnectHandler? {
        didSet {
            socket.onConnect = connectHandler
        }
    }

    public var disconnectHandler: DisconnectHandler? {
        didSet {
            socket.onDisconnect = disconnectHandler
        }
    }

    public var dataHandler: DataHandler? {
        didSet {
            socket.onData = dataHandler
        }
    }
}

public extension Hermes {
    func write(_ data: Data) {
        socket.write(data: data)
    }

    func connect() {
        socket.connect()
    }

    func disconnect() {
        socket.disconnect()
    }
}
