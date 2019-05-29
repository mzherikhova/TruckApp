//
//  Extensions+UIViewController.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 29/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
