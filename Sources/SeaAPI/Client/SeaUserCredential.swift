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
    
    func getRequest(path: String, queryItems: [String: String] = [:]) -> URLRequest {
        var pathAndQuery = path
        if queryItems.count > 0 {
            pathAndQuery = "?" + queryItems.map { [$0, $1].map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! }.joined(separator: "=") }.joined(separator: "&")
        }
        var request = URLRequest(url: baseUrl.appendingPathComponent(pathAndQuery))
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
