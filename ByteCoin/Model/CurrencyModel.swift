//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by Aman Giri on 2024-03-27.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

struct CurrencyModel{
    let rate: Double
    let currencyType: String
    
    var rateFormatted: String {
        return String(format: "%.2f", rate)
    }
}
