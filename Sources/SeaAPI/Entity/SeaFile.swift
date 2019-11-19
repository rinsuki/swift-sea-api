//
//  SeaFile.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaFile: Codable {
    public var id: Int
    public var name: String
    public var type: SeaFileType
    public var variants: [SeaFileVariant]
    
    public init(id: Int, name: String, type: SeaFileType, variants: [SeaFileVariant]) {
        self.id = id
        self.name = name
        self.type = type
        self.variants = variants
    }
}

public enum SeaFileType: String, Codable {
    case image
    case video
}
