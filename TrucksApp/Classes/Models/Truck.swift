//
//  Truck.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 27/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

class Truck: Codable {
    var parameter: String {
        return "\(String(describing: id))\(String(describing: nameTruck))\(String(describing: price)))"
    }
    
    var id: String?
    var nameTruck: String?
    var price: String?
    var comment: String?
}
