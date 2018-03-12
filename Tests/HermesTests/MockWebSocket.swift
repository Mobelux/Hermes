//
//  MockWebSocket.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/12/18.
//

import Foundation
@testable import Hermes

struct MockWebSocket: WebSocket {
    init?(request: Request) {}

    var onConnect: (() -> ())?
    var onDisconnect: ((Error?) -> ())?
    var onData: ((Data) -> ())?

    func connect() {
        onConnect?()
    }

    func disconnect() {
        onDisconnect?(nil)
    }

    func write(data: Data) {}
}
