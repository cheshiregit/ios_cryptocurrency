//
//  RealmModel.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 28.04.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit
import RealmSwift

class RealmModel: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var change24h: String = ""
    @objc dynamic var change7d: String = ""
    @objc dynamic var symbol: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price_usd"
        case change24h = "percent_change_24h"
        case change7d = "percent_change_7d"
        case symbol = "symbol"
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
