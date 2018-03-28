//
//  MessageType.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public enum MessageType: Codable {
    private enum CodingKeys: String, CodingKey {
        case welcome, ping, confirmation, rejection
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if (try? values.decode(String.self, forKey: .welcome)) != nil {
            self = .welcome
            return
        } else if (try? values.decode(String.self, forKey: .ping)) != nil {
            self = .ping
            return
        } else if (try? values.decode(String.self, forKey: .confirmation)) != nil {
            self = .confirmation
            return
        } else if (try? values.decode(String.self, forKey: .rejection)) != nil {
            self = .rejection
            return
        }

        throw NSError()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .welcome:
            try container.encode("", forKey: .welcome)
        case .ping:
            try container.encode("", forKey: .ping)
        case .confirmation:
            try container.encode("", forKey: .confirmation)
        case .rejection:
            try container.encode("", forKey: .rejection)
        }
    }

    case welcome
    case ping
    case confirmation
    case rejection
}
