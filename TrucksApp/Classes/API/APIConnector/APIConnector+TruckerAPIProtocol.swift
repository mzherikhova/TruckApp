//
//  APIConnector+TruckerAPIProtocol.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Alamofire
import Foundation

extension APIConnector: TruckAPIProtocol {
    
    func createTruck(_ nameTruck: String,
                     _ price: String,
                     _ comment: String,
                    _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?) {
        if !APIConnector.isConnectionGood() {
            let error = APIError.slowInternetConnection
            closure?(.failure(error))
            return
        }
        
        let router = APIRouter.truckCreate(nameTruck: nameTruck,
                                           price: price,
                                           comment: comment)
        let request = manager.request(router)
        request.validateTruckApp().responseTruckApp{ [unowned self] (response: DataResponse<TruckResponse>) in
            let result = self.apiResult(from: response)
            closure?(result)
            debugPrint(response)
        }
        debugPrint(request)
    }
    
    func deleteTruck(_ id: Int, _ closure: (() -> Void)?) {
        if !APIConnector.isConnectionGood() {
            let error = APIError.slowInternetConnection
            closure?()
            return
        }
        let router = APIRouter.truckDelete(id: id)
        let request = manager.request(router)
        closure?()
        debugPrint(request)
        
        
    }
    
    func updateTruck(_ id: Int, _ nameTruck: String,
                     _ price: String,
                     _ comment: String, _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?) {
        if !APIConnector.isConnectionGood() {
            let error = APIError.slowInternetConnection
            closure?(.failure(error))
            return
        }
        
        let router = APIRouter.truckUpdate(id: id, nameTruck: nameTruck, price:price, comment: comment)
        let request = manager.request(router)
        request.validateTruckApp().responseTruckApp { [unowned self] (response: DataResponse<TruckResponse>) in
            let result = self.apiResult(from: response)
            closure?(result)
            debugPrint(response)
        }
        debugPrint(request)
    }
    
    func truckers(_ closure: ((APIResult<TrucksResponse, APIError>) -> Void)?) {
        if !APIConnector.isConnectionGood() {
            let error = APIError.slowInternetConnection
            closure?(.failure(error))
            return
        }
        
        let router = APIRouter.truckers
        let request = manager.request(router)
        request.validateTruckApp().responseTruckApp { [unowned self] (response: DataResponse<TrucksResponse>) in
            let result = self.apiResult(from: response)
            closure?(result)
            debugPrint(response)
        }
        debugPrint(request)
    }
}

