//
//  APIRouter.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Alamofire
import Foundation

fileprivate class Config {
    static let baseURLString: String = {
        let bundle = Bundle(for: Config.self)
        let baseURL = bundle.infoDictionary!["APIURL"] as! String
        return baseURL
    }()
}

enum APIRouter {
    
    // MARK: Markers
    case truckCreate(nameTruck: String,
        price: String,
        comment: String)
    case truckDelete(id: Int)
    case truckUpdate(id: Int, nameTruck: String,
        price: String,
        comment: String)
    case truckers
    
}

extension APIRouter: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        let url = try Config.baseURLString.asURL()
        
        //TODO: Подумать как изменить
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        switch self {
            default:
                urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
        urlRequest.httpMethod = method.rawValue
        
    
        var parameters: [String: Any]?
        
        switch self {        // MARK: Markers
            case let .truckCreate(nameTruck, price, comment):
                parameters = ["nameTruck": nameTruck,
                              "price": price,
                              "comment": comment]
            case let .truckDelete(id):
                parameters = ["id": id]
            case let .truckUpdate(id, nameTruck, price, comment):
                parameters = ["id": id, "nameTruck": nameTruck,
                "price": price,
                "comment": comment]
            case .truckers:
                parameters = [:]
                // MARK: Notes
            
        }
        //let encoding = Alamofire.JSONEncoding.default
        if urlRequest.httpMethod == "POST" || urlRequest.httpMethod == "PATCH" {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        }
        
        return urlRequest
    }
    
    var method: HTTPMethod {
        switch self {
            case
            .truckCreate,
            .truckDelete:
                return .post
        case
        .truckUpdate:
            return .patch
            case
            .truckers:
                return .get
            }
    }
    
    var path: String {
        switch self {
            
            // MARK: Markers
            case .truckCreate:
                return "truck/add"
            case .truckDelete:
                return "truck/delete"
        case let .truckUpdate(id,_, _, _):
                return "truck/\(id)"
            case .truckers:
                return "trucks"
            
        }
    }
}


