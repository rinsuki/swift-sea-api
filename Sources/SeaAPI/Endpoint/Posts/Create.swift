//
//  File.swift
//  
//
//  Created by user on 2019/11/19.
//

import Foundation

extension SeaAPI {
    public struct CreatePost: SeaAPIEndpoint, Codable {
        public let endpoint: String = "/api/v1/posts"
        public var body: SeaAPIBody {
            let encoder = JSONEncoder()
            return .httpBody(method: "POST", try! encoder.encode(self))
        }
        public typealias Response = SeaPost
        
        public enum SendNotify: String, Codable {
            case none
            case send
        }
        
        var text: String
        var fileIds: [Int]?
        var sendNotify: SendNotify?
        var inReplyToId: Int?
        
        public init(text: String, fileIds: [Int]? = nil, sendNotify: SendNotify? = nil, inReplyToId: Int? = nil) {
            self.text = text
            self.fileIds = fileIds
            self.sendNotify = sendNotify
            self.inReplyToId = inReplyToId
        }
        
        enum CodingKeys: String, CodingKey {
            case text
            case fileIds
            case sendNotify = "notify"
            case inReplyToId
        }
    }
}
