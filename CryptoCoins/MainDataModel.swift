//
//  MainDataModel.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 11.04.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit

struct DataModel: Codable {
    var id: String
    var price: String
    var change24h: String
    var change7d: String
}

/*
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
