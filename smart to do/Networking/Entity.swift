//
//  Entity.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public typealias JSON = [String: Any]

public protocol Entity: Codable {}

extension Entity {
    public var json: JSON? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
