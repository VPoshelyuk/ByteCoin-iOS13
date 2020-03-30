//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var cManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        cManager.delegate = self
    }
}

//MARK - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cManager.currencyArray.count
    }
}

//MARK - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cManager.getCoinPrice(for: cManager.currencyArray[row])
    }
}

//MARK - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ weatherManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.priceLabel.text = coin.priceSring
            self.currencyLabel.text = coin.currency
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
