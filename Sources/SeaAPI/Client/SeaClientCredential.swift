//
//  SeaClientCredential.swift
//  SeaAPI
//
//  Created by user on 2019/09/04.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public struct SeaClientCredential: Codable {
    public let clientId: String
    public let clientSecret: String
    
    public init(id: String, secret: String) {
        self.clientId = id
        self.clientSecret = secret
    }
}
