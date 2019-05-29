//
//  DataRequest+APIDecodable.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

extension DataRequest {
    public func validateTruckApp() -> Self {
        return validate { _, response, _ in
            switch response.statusCode {
            case 200...299:
                return .success
            case 401:
                return .failure(APIError.unauthorized)
            case 400...499:
                return .failure(APIError.clientError("Client error"))
            case 500...599:
                return .failure(APIError.serverError)
            default:
                return .success
            }
            }.validate()
    }
}

extension DataRequest {
    
    @discardableResult
    func responseTruckApp<T: APIDecodable> (queue: DispatchQueue? = nil,
                                            completionHandler: @escaping (DataResponse<T>) -> Void) -> Self where T == T.DecodedType {
        return response(queue: queue,
                        responseSerializer: DataRequest.truckAppResponseSerializer(),
                        completionHandler: completionHandler)
    }
    
    static func truckAppResponseSerializer<T: APIDecodable>() -> DataResponseSerializer<T> where T == T.DecodedType {
        return DataResponseSerializer { _, _, data, error in
            if let error = error {
                if let e = error as? APIError {
                    return .failure(e)
                }
                let e = error as NSError
                switch e.code {
                case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                    return .failure(APIError.internetNotAvailable)
                case NSURLErrorTimedOut:
                    return .failure(APIError.timeout)
                default:
                    return .failure(APIError.clientError(e.description))
                }
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    return .failure(APIError.clientError("Invalid JSON!"))
            }
            
            let swiftyJson = JSON(json)
            if let statusCode = swiftyJson["error", "status"].int {
                switch statusCode {
                case 401:
                    return .failure(APIError.unauthorized)
                default:
                    return .failure(APIError.serverError)
                }
            }
            
            if let errorMessage = swiftyJson["error", 0, "message"].string {
                return .failure(APIError.serverMessage(errorMessage))
            }
            
            let decoded = T.decode(swiftyJson)
            switch decoded {
            case let .success(value):
                return .success(value)
            case let .failure(message):
                debugPrint("SwiftJSON: " + message)
                return .failure(APIError.clientError(message))
            }
            
            
        }
    }
}
