//
//  SeaAPIJSONDecoder.swift
//  SeaAPI
//
//  Created by user on 2019/08/30.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

public class SeaAPIJSONDecoder: JSONDecoder {
    public override init() {
        super.init()
        dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.custom {
            let container = try $0.singleValueContainer()
            let str = try container.decode(String.self)
            let f = DateFormatter()
            f.calendar = Calendar(identifier: .gregorian)
            f.locale = Locale(identifier: "en_US_POSIX")
            f.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZZZZ"
            return f.date(from: str)!
        }
    }
}
