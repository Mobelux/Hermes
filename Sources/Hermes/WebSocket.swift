//
//  WebSocket.swift
//  Hermes
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation
import Starscream

public protocol WebSocket: class {
    init?(request: Request)

    var isConnected: Bool { get }
    var onConnect: (() -> ())? { get set }
    var onDisconnect: ((Error?) -> ())? { get set }
    var onData: ((Data) -> ())? { get set }
    var onText: ((String) -> Void)? { get set }

    func connect()
    func disconnect()
    func write(data: Data)
}

public class HermesWebSocket: Starscream.WebSocket {
    public required init?(request: Request) {
        guard let request = request as? URLRequest else {
            return nil
        }

        super.init(request: request)
    }
}

extension HermesWebSocket: WebSocket {}
