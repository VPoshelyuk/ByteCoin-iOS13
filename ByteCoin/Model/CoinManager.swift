//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ weatherManager: CoinManager, coin: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "D8AD983E-98C7-439F-9800-5464912D1F5C"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        if let url = URL(string: "\(baseURL)/\(currency)?apikey=\(apiKey)") {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url, completionHandler: {
                        if $2 != nil {
                            self.delegate?.didFailWithError($2!)
                            return
                        }
                        
                        if let safeData = $0 {
                            if let coin = self.parseJSON(safeData) {
                                self.delegate?.didUpdateCurrency(self, coin: coin)

                            }
                        }
                    })
                    task.resume()
                }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            return CoinModel(coin: decodedData.asset_id_base, currency: decodedData.asset_id_quote, price: decodedData.rate)
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
