//
//  MainDataModel.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 11.04.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit

class DataModel: Decodable {
    var id: String = ""
    var price: String = ""
    var change24h: String = ""
    var change7d: String = ""
    var symbol: String = ""
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price_usd"
        case change24h = "percent_change_24h"
        case change7d = "percent_change_7d"
        case symbol = "symbol"
    }
}

/*
 
 let id = item["id"] as! String
 let price = item["price_usd"] as! String
 let change24h = item["percent_change_24h"] as! String
 let change7d = item["percent_change_7d"] as! String
 
class MainDataModel {
    var id: String
    var price: String
    var change24h: String
    var change7d: String
    
    init(id: String, price: String, change24h: String, change7d: String) {
        self.id = id
        self.price = price
        self.change24h = change24h
        self.change7d = change7d
    }
}
*/
