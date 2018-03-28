//
//  Instruction.swift
//  HermesPackageDescription
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public struct Instruction: Codable, Equatable {
    public static func ==(lhs: Instruction, rhs: Instruction) -> Bool {
        return lhs.command == rhs.command
    }
    let command: Command
    let identifier: Identifier
    let data: Data?

}

