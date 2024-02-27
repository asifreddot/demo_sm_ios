//
//  GenericResponse.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public struct GenericResponse<T:Entity>: Entity {
    public var data: [T]?
    public var status: Int?
    public var message: String?

    public enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Int.self, forKey: .status)
        self.message = try container.decode(String.self, forKey: .message)
        do {
            self.data = try container.decode([T].self, forKey: .data)
        } catch {
            let tType = try container.decode(T.self, forKey: .data)
            self.data = [tType]
        }
    }
}
