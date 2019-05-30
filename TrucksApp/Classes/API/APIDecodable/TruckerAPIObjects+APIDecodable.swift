//
//  TruckerAPIObjects+APIDecodable.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation
import SwiftyJSON

extension TruckResponseModel: APIDecodable {
    public static func decode(_ json: JSON) -> APIDecoded<TruckResponseModel> {
        guard let id = json["id"].int ?? Int(json["id"].string!) else {
            return .failure(APIDecodableConstants.cantDecodableMessage + " \(json)")
        } // HotFi
        
        guard let nameTruck = json["nameTruck"].string,
            let price = json["price"].string,
            let comment = json["comment"].string
             else {
                return .failure(APIDecodableConstants.cantDecodableMessage + " \(json)")
        }
        let trucker = TruckResponseModel(id: id,
                                         nameTruck: nameTruck,
                                         price: price,
                                         comment: comment)
        return .success(trucker)
    }
}

extension TrucksResponse: APIDecodable {
    public static func decode(_ json: JSON) -> APIDecoded<TrucksResponse> {
        guard let array = json.array else {
            return .failure(APIDecodableConstants.cantDecodableMessage + " \(self)")
        }
        var truckers = array.flatMap({ TruckResponseModel.decode($0).data })
        truckers = truckers.filter{$0.isValid}
        let resp = TrucksResponse(truckers: truckers)
        return .success(resp)
    }
}

extension TruckResponse: APIDecodable {
    public static func decode(_ json: JSON) -> APIDecoded<TruckResponse> {
        let decoded = TruckResponseModel.decode(json)
        switch decoded {
        case let .success(value):
            return .success(TruckResponse(trucker: value))
        case let .failure(value):
            return .failure(value)
        }
    }
}
