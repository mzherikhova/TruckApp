//
//  DependencyInjection.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation
import Swinject

fileprivate class DependencyInjection {
    static let container = Container(parent: nil) { (container) in
        // MARK: API
        let apiConnector = APIConnector()
 
        // MARK: Markers
        container.register(TruckAPIProtocol.self, factory: { _ in apiConnector })
        container.register(TruckAPIManager.self, factory: { _ in
            TruckAPIManager(apiProtocol: container.resolve(TruckAPIProtocol.self)!)
        }).inObjectScope(.container)
        
    }
}



extension TruckAPIManager {
    static var shared: TruckAPIManager {
        return DependencyInjection.container.resolve(TruckAPIManager.self)! }
}

