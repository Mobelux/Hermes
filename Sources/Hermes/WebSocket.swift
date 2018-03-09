//
//  WebSocket.swift
//  Hermes
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation
import Starscream

public protocol WebSocket {
    init?(request: Request)

    var onConnect: (() -> Void)? { get set }
    var onDisconnect: ((Error?) -> Void)? { get set }
    var onData: ((Data) -> Void)? { get set }

    func connect()
    func disconnect()
    func write(data: Data)
}

class InternalWebSocket: Starscream.WebSocket {
    required init?(request: Request) {
        guard let request = request as? URLRequest else {
            return nil
        }

        super.init(request: request)
    }
}

extension InternalWebSocket: WebSocket {}
