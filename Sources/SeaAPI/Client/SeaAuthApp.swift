//
//  SeaAuthApp.swift
//  Sail
//
//  Created by user on 2019/08/29.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct SeaAuthApp {
    public let baseUrl: URL
    public let credential: SeaClientCredential
    
    public init(baseUrl: URL, credential: SeaClientCredential) {
        self.baseUrl = baseUrl
        self.credential = credential
    }
}


extension SeaAuthApp {
    public func getOAuthUrl(state: String? = nil) -> URL {
        var queryItems = [
            URLQueryItem(name: "client_id", value: credential.clientId),
            URLQueryItem(name: "response_type", value: "code"),
        ]
        if let state = state { queryItems.append(URLQueryItem(name: "state", value: state)) }
        var components = URLComponents()
        components.path = "oauth/authorize"
        components.queryItems = queryItems
        return components.url(relativeTo: baseUrl)!
    }
    
    enum OAuthGrantType: String, Codable {
        case code = "authorization_code"
    }
    
    struct OAuthTokenRequest: Codable {
        let clientId: String
        let clientSecret: String
        let code: String
        let grantType: OAuthGrantType
        let state: String?
        let includeUserObject = "v1"
        
        enum CodingKeys: String, CodingKey {
            case clientId = "client_id"
            case clientSecret = "client_secret"
            case code
            case grantType = "grant_type"
            case state
            case includeUserObject = "include_user_object"
        }
        
        init(app: SeaAuthApp, code: String, state: String? = nil, grantType: OAuthGrantType = .code) {
            self.clientId = app.credential.clientId
            self.clientSecret = app.credential.clientSecret
            self.code = code
            self.grantType = grantType
            self.state = state
        }
    }
    
    public func getOAuthToken(code: String, state: String? = nil, callback: @escaping (Result<(token: String, user: SeaUser), Error>) -> Void) -> URLSessionDataTask {
        var components = URLComponents()
        components.path = "oauth/token"
        var request = URLRequest(url: components.url(relativeTo: baseUrl)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: .infinity)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(OAuthTokenRequest(app: self, code: code, state: state, grantType: .code))
        struct GetTokenResult: Decodable {
            var access_token: String
            var user: SeaUser
        }
        return SeaURLSession.decodableTask(with: request) { (result: Result<GetTokenResult, Error>) in
            switch result {
            case .success(let result):
                callback(.success((token: result.access_token, user: result.user)))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
