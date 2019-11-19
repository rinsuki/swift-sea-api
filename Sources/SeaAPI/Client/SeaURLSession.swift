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

func getSeaURLSessionConfiguration() -> URLSessionConfiguration {
    let config = URLSessionConfiguration.ephemeral
    config.urlCache = nil
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    return config
}

public var SeaURLSession = URLSession(configuration: getSeaURLSessionConfiguration())
