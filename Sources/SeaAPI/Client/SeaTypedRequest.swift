//
//  File.swift
//  
//
//  Created by user on 2019/11/19.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum SeaAPIBody {
    case query([String: String])
    case httpBody(method: String, Data)
}

public protocol SeaAPIEndpoint {
    var endpoint: String { get }
    var body: SeaAPIBody { get }
    associatedtype Response
}

public enum SeaAPIError: Decodable {
    public init(from decoder: Decoder) throws {
        self = .simple(try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .message))
    }
    
    case simple(String)
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct SeaAPIErrorWrapper: Decodable {
    let errors: [SeaAPIError]
}

public enum SeaRequestError: Error {
    case apiError([SeaAPIError])
    case unknownError(String)
}

extension SeaUserCredential {
    public func request<Endpoint: SeaAPIEndpoint>(r: Endpoint, callback: @escaping (Result<Endpoint.Response, Error>) -> Void)
        where Endpoint.Response: Decodable {
        var httpReq: URLRequest
        switch r.body {
        case .query(let params):
            httpReq = getRequest(path: r.endpoint, queryItems: params)
        case .httpBody(let method, let data):
            httpReq = getRequest(path: r.endpoint)
            httpReq.httpMethod = method
            httpReq.httpBody = data
        }
        SeaURLSession.dataTask(with: httpReq) { data, res, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let res = res as? HTTPURLResponse else {
                callback(.failure(SeaRequestError.unknownError("res == nil")))
                return
            }
            guard let data = data else {
                callback(.failure(SeaRequestError.unknownError("data == nil")))
                return
            }
            if res.statusCode >= 400 {
                callback(.init {
                    throw SeaRequestError.apiError(try SeaAPIJSONDecoder().decode(SeaAPIErrorWrapper.self, from: data).errors)
                })
            }
            let decoder = SeaAPIJSONDecoder()
            callback(Result { try decoder.decode(Endpoint.Response.self, from: data) })
        }
    }
}
