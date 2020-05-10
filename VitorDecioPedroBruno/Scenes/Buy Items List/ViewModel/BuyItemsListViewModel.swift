//
//  BuyItemsListViewModel.swift
//  VitorDecioPedroBruno
//
//  Created by Bruno Cortez on 5/10/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation

class BuyItemsListViewModel {
    let coredataManager = CoredataManager()
    var products: [Product] = []

    func getBuyItems() -> [Product] {
        do {
            try products = coredataManager.fetchProducts()
        } catch { }
        return products
    }
}
