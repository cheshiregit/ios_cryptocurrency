//
//  CustomTableViewCell.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 21.03.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
