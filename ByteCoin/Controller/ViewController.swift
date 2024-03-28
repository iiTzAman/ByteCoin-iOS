//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var currenyNameLabel: UILabel!
    @IBOutlet weak var currencyOutputLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
        coinManager.fetchCurrencyRates(coinManager.currencyArray[row])
    }
}

extension ViewController: CurrencyRateUpdateDelegate {
    func currencyRateDidUpdate(_ coinManager: CoinManager, currencyData: CurrencyModel) {
        DispatchQueue.main.async{
            self.currenyNameLabel.text = currencyData.currencyType
            self.currencyOutputLabel.text = currencyData.rateFormatted
        }
    }
    
    
}
