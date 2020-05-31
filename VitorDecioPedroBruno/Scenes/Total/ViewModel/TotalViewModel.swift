//
//  TotalViewModel.swift
//  VitorDecioPedroBruno
//
//  Created by Bruno Cortez on 5/10/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation

class TotalViewModel {
    let coredataManager = CoredataManager()
    var products: [Product] = []
    var states: [State] = []
    let IOF: Double = SettingsManager.shared.taxValue
    let DOLLAR_PRICE: Double = SettingsManager.shared.dollarValue
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        do {
            try products = coredataManager.fetchProducts()
            try states = coredataManager.fetchStates()
        } catch {}
    }
    
    func getTotalDollar() -> String {
        var total = 0.0
        for product in products {
            total += product.price
        }
        return "\(total)"
    }
    
    func getTotalReais() -> String {
        var total = 0.0
        
        for product in products {
            var productTotal = product.price
            for state in states {
                if (product.state == state) { productTotal += ((productTotal * state.tax)/100) }
            }
            productTotal = productTotal * DOLLAR_PRICE
            if (product.creditCardBuy) { productTotal += ((productTotal * IOF)/100) }
            total += productTotal
        }
        
        return "\(total)"
    }
}
