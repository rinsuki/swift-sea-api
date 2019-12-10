//
//  File.swift
//  
//
//  Created by user on 2019/12/10.
//

import Foundation

extension SeaAPI {
    public struct PublicTimeline: SeaAPIEndpoint, Codable {
        public let endpoint: String = "/api/v1/timelines/public"
        public var body: SeaAPIBody {
            let params: [String: CustomStringConvertible?] = [
                "count": count,
                "sinceId": sinceId,
                "maxId": maxId,
                "search": search,
            ]
            return .query(params.compactMapValues({ $0?.description }))
        }
        public typealias Response = [SeaPost]
        
        var count: Int?
        var sinceId: Int?
        var maxId: Int?
        var search: String?
        
        public init(count: Int? = nil, sinceId: Int? = nil, maxId: Int? = nil, search: String? = nil) {
            self.count = count
            self.sinceId = sinceId
            self.maxId = maxId
            self.search = search
        }
    }
}
