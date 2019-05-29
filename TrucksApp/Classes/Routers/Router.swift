//
//  Router.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 27/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

final class Router {
    static let shared = Router()
    var objNav:UINavigationController!
    
    private init() {}
    
    func root(_ window: inout UIWindow?) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        let vc =  TrucksListViewController()
        objNav = UINavigationController(rootViewController: vc)
        objNav.isNavigationBarHidden = false
        window?.rootViewController = objNav
    }
}
