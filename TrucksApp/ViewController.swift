//
//  ViewController.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 27/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        request("http://jsonplaceholder.typicode.com/posts").responseJSON { response in
            print(response)
        }
        print("viewDidLoad ended")
        // Do any additional setup after loading the view.
    }


}

