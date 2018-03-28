//
//  Command.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public enum Command: Codable {
    private enum CodingKeys: String, CodingKey {
        case subscribe, unsubscribe, message
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if (try? values.decode(String.self, forKey: .subscribe)) != nil {
            self = .subscribe
            return
        } else if (try? values.decode(String.self, forKey: .unsubscribe)) != nil {
            self = .unsubscribe
            return
        } else if (try? values.decode(String.self, forKey: .message)) != nil {
            self = .message
            return
        }

        throw NSError()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .subscribe:
            try container.encode("", forKey: .subscribe)
        case .unsubscribe:
            try container.encode("", forKey: .unsubscribe)
        case .message:
            try container.encode("", forKey: .message)
        }
    }

    case subscribe
    case unsubscribe
    case message
}
