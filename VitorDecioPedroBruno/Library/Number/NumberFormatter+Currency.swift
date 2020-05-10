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
    case enUS = "U$"
    
    var locale: Locale {
        switch self {
        case .enUS:
            return Locale(identifier: "pt_BR")
        case .ptBR:
            return Locale(identifier: "en_US")
        }
    }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
    static func createFormatter(with currencySymbol: CurrencySymbol) -> NumberFormatter {
        let formatter = NumberFormatter(numberStyle: .currency)
            if #available(iOS 12.0, *) {
                formatter.currencySymbol = currencySymbol.rawValue
            } else {
                formatter.currencySymbol = currencySymbol.rawValue + " "
            }
            formatter.allowsFloats = true
            formatter.decimalSeparator = ","
            formatter.groupingSeparator = "."
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            formatter.locale = currencySymbol.locale
            return formatter
    }
}
