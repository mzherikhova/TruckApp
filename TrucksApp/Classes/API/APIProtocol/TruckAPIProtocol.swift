//
//  TruckerAPIProtocol.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

protocol TruckAPIProtocol {
    func createTruck(
                      _ nameTruck: String,
                      _ price: String,
                      _ comment: String,
                      _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?)
    func deleteTruck(_ id: Int, _ closure: ((APIResult<EmptyResponse, APIError>) -> Void)?)
    func updateTruck(_ id: Int,
                       _ nameTruck: String,
                       _ price: String,
                       _ comment: String,
                      _ closure: ((APIResult<TruckResponse, APIError>) -> Void)?)
    func truckers(_ closure: ((APIResult<TrucksResponse, APIError>) -> Void)?)
}
