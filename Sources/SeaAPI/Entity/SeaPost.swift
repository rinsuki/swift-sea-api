//
//  SeaPost.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaPost: Codable, Identifiable, Hashable {
    public var id: Int
    public var text: String
    public var user: SeaUser
    public var application: SeaApplication
    public var createdAt: Date
    public var updatedAt: Date
    public var files: [SeaFile]
    
    public init(id: Int, text: String, user: SeaUser, application: SeaApplication, createdAt: Date, updatedAt: Date, files: [SeaFile]) {
        self.id = id
        self.text = text
        self.user = user
        self.application = application
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.files = files
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: SeaPost, rhs: SeaPost) -> Bool {
        return lhs.id == rhs.id
    }
}
