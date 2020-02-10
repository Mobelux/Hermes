//
//  MockWebSocket.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/12/18.
//

import Foundation
@testable import Hermes

class MockWebSocket: WebSocket {
    private var _isConnected: Bool = false

    required init?(request: Request) {}

    var isConnected: Bool { _isConnected }
    var onConnect: (() -> ())?
    var onDisconnect: ((Error?) -> ())?
    var onData: ((Data) -> ())?
    var onText: ((String) -> ())?

    func connect() {
        _isConnected = true
        onConnect?()
    }

    func disconnect() {
        _isConnected = false
        onDisconnect?(nil)
    }

    func write(data: Data) {}
}
