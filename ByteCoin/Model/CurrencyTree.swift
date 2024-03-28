//
//  CurrencyTree.swift
//  ByteCoin
//
//  Created by Aman Giri on 2024-03-27.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

struct CurrencyTree: Codable{
    let asset_id_base: String
    let rates: [Rates]
}

struct Rates: Codable{
    let time: String
    let asset_id_quote: String
    let rate: Double
}
