//
//  Double+Formatter.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormat: String {
        return NumberFormatter.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }

    var percentFormat: String {
        return NumberFormatter.percentageFormatter.string(for: self / 100) ?? ""
    }
}
