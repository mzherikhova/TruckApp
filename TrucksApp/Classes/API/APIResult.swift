//
//  APIResult.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

enum APIError: Error {
    case serverMessage(String)
    case internetNotAvailable
    case timeout
    case serverError
    case clientError(String)
    case unauthorized
    case slowInternetConnection
    
    var message: String {
        switch self {
        case .serverError:
            return "alertUnknownError"
        case .clientError:
            return "alertUnknownError"
        case .internetNotAvailable:
            return "alertInternetNotAvaible"
        case .timeout:
            return "alertInternetNotAvaible"
        case .unauthorized:
            return "alertUnauthorized"
        case .serverMessage(let message):
            return message
        case .slowInternetConnection:
            return "alertSlowInternetConnection"
        }
    }
}

enum APIResult<DataType, ErrorType> {
    case success(DataType)
    case failure(ErrorType)
}

struct EmptyResponse { }
