//
//  MockSocketWrapper.swift
//  ActionCableTests
//
//  Created by Jeremy Greenwood on 3/12/18.
//

import Foundation
@testable import Hermes

struct MockSocketWrapper: WebSocketWrapper {
    init(socket: WebSocket?) {}

    var textHandler: TextHandler?

    init(socket: WebSocket) {}

    var connectHandler: ConnectHandler?

    var disconnectHandler: DisconnectHandler?

    var dataHandler: DataHandler?

    func write(_ data: Data) {
        // handle data
    }

    func connect() {
        connectHandler?()
    }

    func disconnect() {
        disconnectHandler?(nil)
    }
}
