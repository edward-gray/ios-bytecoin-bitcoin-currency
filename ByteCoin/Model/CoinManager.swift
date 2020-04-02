//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateWeather(_ coinManager: CoinManager, rate: String)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    //MARK: - API INFO
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
<<<<<<< HEAD
    let apiKey = "E17FECEE-0882-4D0B-943B-36133D472239"
=======
    let apiKey = "You can get api key From https://docs.coinapi.io/"
>>>>>>> da852026e36cb243fdca1218c4dc0d3170d9cfe2
    
    //MARK: - Variables
    let currencyArray =
        ["AUD", "BRL","CAD",
        "CNY","EUR","GBP",
        "HKD","IDR","ILS",
        "INR","JPY","MXN",
        "NOK","NZD","PLN",
        "RON","RUB","SEK",
        "SGD","USD","ZAR"]
    
    var selectedCurrency = "AUD"
    var delegate: CoinManagerDelegate?
    

    //MARK: - methods
    mutating func getCoinPrice(for currency: String) {
        selectedCurrency = currency
        fetchData()
    }
    
    func fetchData() {
        let urlString = "\(baseURL)/\(selectedCurrency)?apiKey=\(apiKey)"
        
        // 1. create URL
        if let url = URL(string: urlString) {
            
            // 2. get URLSession
            let session = URLSession(configuration: .default)
            
            // 3. make a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    let price: String = self.parseJSON(safeData)
                    if price != "" {
                        self.delegate?.didUpdateWeather(self, rate: price)
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> String {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: data)
            return String(format: "%.2f", decodedData.rate)
        } catch {
            print(error)
            delegate?.didFailWithError(self, error: error)
            return ""
        }
    }
    
    
}
