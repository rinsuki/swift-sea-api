//
//  File.swift
//  
//
//  Created by user on 2019/12/13.
//

import Foundation

extension SeaAPI {
    struct UploadFileToAlbum: SeaAPIEndpoint, Encodable {
        public let endpoint: String = "/api/v1/album/files/raw_upload"
        public var body: SeaAPIBody {
            return .httpBody(method: "POST", data)
        }
        public var headers: [String: String] {
            let encoder = JSONEncoder()
            return [
                "Content-Type": "application/octet-stream",
                "X-Sea-API-Arg": String(data: try! encoder.encode(self), encoding: .utf8)!
            ]
        }
        typealias Response = SeaFile
        
        enum IfNameConflicted: String, Codable {
            case error
            case addDateString = "add-date-string"
        }
        
        var name: String
        var ifNameConflicted: IfNameConflicted
        var folderId: Int?
        var data: Data
        
        enum CodingKeys: String, CodingKey {
            case name
            case folderId
            case ifNameConflicted
        }
    }
}
