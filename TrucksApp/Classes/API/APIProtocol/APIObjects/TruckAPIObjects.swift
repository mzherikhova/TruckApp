//
//  TruckerAPIObjects.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//
protocol TruckParameters {
    var id: Int { get set }
    var nameTruck: String { get set }
    var price: String { get set }
    var comment: String { get set }
}
struct TruckResponseModel: TruckParameters {
    var id: Int
    var nameTruck: String
    var price: String
    var comment: String
    
    var isValid: Bool {
        guard !(price ).isEmpty, !(nameTruck ).isEmpty, id != nil, Int(price) ?? 0 > 0 else {
            return false
        }
        
        return true
    }
}

struct TrucksResponse {
    var truckers: [TruckResponseModel]
}

struct TruckResponse {
    var trucker: TruckResponseModel
}
