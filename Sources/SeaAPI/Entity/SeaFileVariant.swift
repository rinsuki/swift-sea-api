//
//  SeaFileVariant.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaFileVariant: Codable {
    public var id: Int
    public var score: Int
    public var `extension`: String
    public var type: String
    public var size: Int
    public var url: URL
    public var mime: String
    
    public init(id: Int, score: Int, `extension`: String, type: String, size: Int, url: URL, mime: String) {
        self.id = id
        self.score = score
        self.extension = `extension`
        self.type = type
        self.size = size
        self.url = url
        self.mime = mime
    }
}
