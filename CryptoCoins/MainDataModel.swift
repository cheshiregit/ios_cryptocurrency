//
//  MainDataModel.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 11.04.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit

class DataModel: Decodable {
    var name: String = ""
    var price: String = ""
    var change24h: String = ""
    var change7d: String = ""
    var symbol: String = ""
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price_usd"
        case change24h = "percent_change_24h"
        case change7d = "percent_change_7d"
        case symbol = "symbol"
    }
}

