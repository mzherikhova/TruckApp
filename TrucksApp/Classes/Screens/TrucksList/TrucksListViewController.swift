//
//  TrucksListViewController.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 27/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import MBProgressHUD

class TrucksListViewController: UIViewController {
    
    @IBOutlet weak var truckTableView: UITableView!
    private var trucks: [TruckResponseModel] = [] {
        didSet {
            truckTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Список грузовиков"
        registerCells()
        delegating()
        addRightButton()
        getTrucks()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTrucks()
    }
    private func getTrucks() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification?.mode = MBProgressHUDMode.indeterminate
        
        TruckAPIManager.shared.truckers{ [weak weakSelf = self] (result) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            switch result {
            case let .success(data):
                self.trucks = data.truckers
                
            case .failure(let error):
                weakSelf?.showAlert(with: "Ошибка", and: error.message)
                break
                
            }          // Do any additional setup after loading the view.
        }
    }
    private func registerCells() {
        truckTableView.register(TruckTableViewCell.nib, forCellReuseIdentifier: "truckCell")
    }
    private func delegating() {
        truckTableView.delegate = self
        truckTableView.dataSource = self
    }
    private func addRightButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightButtonClicked))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func rightButtonClicked() {
        let vc = TruckAddViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension TrucksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let vc = TruckAddViewController()
        vc.currentTruck = trucks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

extension TrucksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TruckTableViewCell
        cell.idLabel.text = String(trucks[indexPath.row].id)
        cell.nameLabel.text = trucks[indexPath.row].nameTruck
        cell.priceLabel?.text = trucks[indexPath.row].price
        cell.commentTextView?.text = trucks[indexPath.row].comment
        return cell
    }
}


