//
//  Instruction.swift
//  HermesPackageDescription
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public struct Instruction: Codable {
    let command: Command
    let identifier: Identifier
    let data: Data?
}
