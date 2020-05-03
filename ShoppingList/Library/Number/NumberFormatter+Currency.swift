//
//  NumberFormatter+Currency.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation

enum CurrencySymbol: String {
    case ptBR = "R$"
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }

    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter(numberStyle: .currency)
        if #available(iOS 12.0, *) {
            formatter.currencySymbol = CurrencySymbol.ptBR.rawValue
        } else {
            formatter.currencySymbol = CurrencySymbol.ptBR.rawValue + " "
        }
        formatter.allowsFloats = true
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }
}
