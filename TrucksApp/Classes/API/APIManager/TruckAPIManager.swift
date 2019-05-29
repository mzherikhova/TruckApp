//
//  TruckerAPIManager.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

class TruckAPIManager {
    fileprivate let apiProtocol: TruckAPIProtocol
    
    init(apiProtocol: TruckAPIProtocol) {
        self.apiProtocol = apiProtocol
    }
}

extension TruckAPIManager: TruckAPIProtocol {
    func createTruck(_ nameTruck: String,
                     _ price: String,
                     _ comment: String,
                      _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?) {
        apiProtocol.createTruck(nameTruck, price, comment, closure)
    }
    
    func deleteTruck(_ id: Int, _ closure: ((APIResult<EmptyResponse, APIError>) -> Void)?) {
        apiProtocol.deleteTruck(id, closure)
    }
    
    func updateTruck(_ id: Int,
                     _ nameTruck: String,
                     _ price: String,
                     _ comment: String,
                      _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?) {
        apiProtocol.updateTruck(id, nameTruck, price, comment, closure)
    }
    
    func truckers(_ closure: ((APIResult<TrucksResponse, APIError>) -> Void)?) {
        apiProtocol.truckers(closure)
    }
    
}
