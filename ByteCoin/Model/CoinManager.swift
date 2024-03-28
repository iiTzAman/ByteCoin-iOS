//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CurrencyRateUpdateDelegate {
    func currencyRateDidUpdate(_ coinManager: CoinManager, currencyData: CurrencyModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "43D1971E-6E6C-4439-99F1-F022B2599E46"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CurrencyRateUpdateDelegate?
    
    var rawURL: String{
        return "\(baseURL)?apikey=\(apiKey)"
    }
    
    
    func fetchCurrencyRates(_ currencyName: String) {
        if let url = URL(string: rawURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching data from API", error)
                }
                
                if let rawData = data {
                    if let currencyData = jsonParser(rawData, currencyName){
                        delegate?.currencyRateDidUpdate(self, currencyData: currencyData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func jsonParser(_ rawData: Data, _ currencyName: String) -> CurrencyModel?{
        let decoder = JSONDecoder()
        do{
            let currencyData = try decoder.decode(CurrencyTree.self, from: rawData)
            let rates = currencyData.rates
            var rate = 0.00
            var currencyType = ""
            rates.map { item in
                if item.asset_id_quote == currencyName{
                    rate = item.rate
                    currencyType = item.asset_id_quote
                }
            }
            return CurrencyModel(rate: rate, currencyType: currencyType)
            
        } catch {
            print("Error Parsing Data", error)
            return nil
        }
    }
    
    
}
