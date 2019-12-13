//
//  File.swift
//  
//
//  Created by user on 2019/12/13.
//

import Foundation

extension SeaAPI {
    public struct UploadFileToAlbum: SeaAPIEndpoint, Encodable {
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
        public typealias Response = SeaFile
        
        public enum IfNameConflicted: String, Codable {
            case error
            case addDateString = "add-date-string"
        }
        
        var data: Data
        var name: String
        var ifNameConflicted: IfNameConflicted
        var folderId: Int?
        
        public init(data: Data, name: String, ifNameConflicted: IfNameConflicted = .addDateString, folderId: Int? = nil) {
            self.data = data
            self.name = name
            self.ifNameConflicted = ifNameConflicted
            self.folderId = folderId
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case folderId
            case ifNameConflicted
        }
    }
}
