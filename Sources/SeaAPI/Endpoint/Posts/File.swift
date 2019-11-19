//
//  File.swift
//  
//
//  Created by user on 2019/11/19.
//

import Foundation

extension SeaAPI {
    struct CreatePost: SeaAPIEndpoint, Codable {
        let endpoint: String = "/api/v1/posts"
        var body: SeaAPIBody {
            let encoder = JSONEncoder()
            return .httpBody(method: "POST", try! encoder.encode(self))
        }
        typealias Response = SeaPost
        
        enum SendNotify: String, Codable {
            case none
            case send
        }
        
        var text: String
        var fileIds: [Int]?
        var sendNotify: SendNotify?
        
        enum CodingKeys: String, CodingKey {
            case text
            case fileIds
            case sendNotify = "notify"
        }
    }
}
