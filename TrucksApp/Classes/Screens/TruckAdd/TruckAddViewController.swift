//
//  TruckAddViewController.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 27/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class TruckAddViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextView!
    var currentTruck:TruckResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        decorator()
        title = "Добавить Новый Грузовик"
        if let temp = currentTruck {
            setupTruck(truck: temp)
            title = "Редактировать Грузовик"
        }

        // Do any additional setup after loading the view.
    }
    
    private func decorator() {
        self.commentTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.commentTextField.layer.borderWidth = 1
    }
    private func setupTruck(truck: TruckResponseModel) {
        nameTextField.text = truck.nameTruck
        priceTextField.text = truck.price
        commentTextField.text = truck.comment
    }
    private func addRightButton() {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightButtonClicked))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func rightButtonClicked() {
        let name = nameTextField.text ?? ""
        let price = priceTextField.text ?? ""
        let comment = commentTextField.text ?? ""
        
        guard !name.isEmpty && !price.isEmpty else {
            showAlert(with: "Ошибка", and: "Заполните все поля")
            return
        }
        guard (Int(price) != nil) else {
            showAlert(with: "Ошибка", and: "Цена должна быть Int")
            return
        }
        if let truck = currentTruck {
            TruckAPIManager.shared.updateTruck(truck.id, name, price, comment) { [weak weakSelf = self] (result) in
                    switch result {
                        case .success(_):
                            _ = weakSelf?.navigationController?.popViewController(animated: true)
                        case .failure(let error):
                        weakSelf?.showAlert(with: "Ошибка", and: error.message)
                        break
                        
                }          // Do any addit
            }
            
        } else {
            TruckAPIManager.shared.createTruck(name, price, comment) { [weak weakSelf = self] (result) in
                switch result {
                case .success(_): 
                     _ = weakSelf?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    weakSelf?.showAlert(with: "Ошибка", and: error.message)
                    break
                    
                }          // Do any addit
            }
        }
    }
}
