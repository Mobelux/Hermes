//
//  Request.swift
//  Hermes
//
//  Created by Jeremy Greenwood on 3/9/18.
//

import Foundation

public protocol Request {
    var httpMethod: String? { get set }

    init(url: URL)
    mutating func addValue(_ value: String, forHTTPHeaderField field: String)
}

extension URLRequest: Request {
    public init(url: URL) {
        self.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    }
}
