//
//  SeaUserCredential.swift
//  SeaAPI
//
//  Created by user on 2019/11/16.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct SeaUserCredential: Codable {
    let baseUrl: URL
    let token: String
    
    public init(baseUrl: URL, token: String) {
        self.baseUrl = baseUrl
        self.token = token
    }
    
    func getRequest(path: String, queryItems: [String: String] = [:]) -> URLRequest {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!
        urlComponents.path += path
        urlComponents.queryItems = queryItems.map { .init(name: $0, value: $1) }
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
