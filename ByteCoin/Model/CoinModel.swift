//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Slava Pashaliuk on 3/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let coin: String
    let currency: String
    let price: Double
    
    var priceSring: String {
        return String(format: "%.4f", price)
    }
}
