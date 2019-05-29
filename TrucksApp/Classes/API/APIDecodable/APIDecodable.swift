//
//  APIDecodable.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APIDecodableConstants {
    static let cantDecodableMessage = "APIDecodable: Can't decodable"
}

enum APIDecoded<DataType> {
    case success(DataType)
    case failure(String)
    
    var data: DataType? {
        switch self {
        case let .success(data):
            return data
        default:
            return nil
        }
    }
}

protocol APIDecodable {
    associatedtype DecodedType = Self
    static func decode(_ json: JSON) -> APIDecoded<DecodedType>
}

