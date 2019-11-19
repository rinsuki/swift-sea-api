//
//  SeaApplication.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaApplication: Codable {
    public var id: Int
    public var name: String
    public var isAutomated: Bool
    
    public init(id: Int, name: String, isAutomated: Bool) {
        self.id = id
        self.name = name
        self.isAutomated = isAutomated
    }
}
