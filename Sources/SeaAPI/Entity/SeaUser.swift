//
//  SeaUser.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaUser {
    public var id: Int
    public var name: String
    public var screenName: String
    public var postsCount: Int
    public var createdAt: Date
    public var updatedAt: Date
    public var avatarFile: SeaFile?
    
    public init(id: Int, name: String, screenName: String, postsCount: Int, createdAt: Date, updatedAt: Date, avatarFile: SeaFile?) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.postsCount = postsCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.avatarFile = avatarFile
    }
}

extension SeaUser: Codable {
}
