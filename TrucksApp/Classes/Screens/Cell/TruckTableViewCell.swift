//
//  TruckTableViewCell.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 29/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class TruckTableViewCell: UITableViewCell , NibLoadable {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
