//
//  BaseResponse.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public struct BaseResponse: Entity{
    public var status: Int?
    public var message: String?

    public enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    public init(status: Int? = nil, message: String? = nil) {
        self.status = status
        self.message = message
    }
}

public struct BaseResponseString: Entity {
    public var status: Int?
    public var message: String?
    public var data: String?
}
