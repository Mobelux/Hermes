//
//  Status.swift
//  ActionCable
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public struct Status: Codable {
    let type: MessageType
    let identifier: Identifier
}
