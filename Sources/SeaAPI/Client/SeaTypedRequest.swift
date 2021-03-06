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
    var headers: [String: String] { get }
    associatedtype Response
}

public extension SeaAPIEndpoint {
    var headers: [String: String] { return .init() }
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

extension URLSession {
    func decodableTask<T: Decodable>(with: URLRequest, callback: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: with) { data, res, error in
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
                return
            }
            let decoder = SeaAPIJSONDecoder()
            callback(Result { try decoder.decode(T.self, from: data) })
        }
    }
}

extension SeaUserCredential {
    public func request<Endpoint: SeaAPIEndpoint>(r: Endpoint, callback: @escaping (Result<Endpoint.Response, Error>) -> Void) -> URLSessionDataTask
        where Endpoint.Response: Decodable {
        var httpReq: URLRequest
        switch r.body {
        case .query(let params):
            httpReq = getRequest(path: r.endpoint, queryItems: params)
        case .httpBody(let method, let data):
            httpReq = getRequest(path: r.endpoint)
            httpReq.httpMethod = method
            httpReq.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            httpReq.httpBody = data
        }
        for (key, value) in r.headers {
            httpReq.setValue(value, forHTTPHeaderField: key)
        }
        return SeaURLSession.decodableTask(with: httpReq, callback: callback)
    }
}
