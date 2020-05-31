//
//  SettingsManager.swift
//  VitorDecioPedroBruno
//
//  Created by Pedro Xudre on 10/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation

struct SettingsDefault {
    static let DollarDefault = 3.2
    static let TaxDefault = 6.38
}

enum Keys: String {
    case kDollar
    case kTax
}

struct SettingsManager {
    static let shared = SettingsManager()

    private init() {}

    var dollarValue: Double {
        let value = UserDefaults.standard.double(forKey: Keys.kDollar.rawValue)
        
        return value > 0 ? value : SettingsDefault.DollarDefault
    }

    var taxValue: Double {
        let value = UserDefaults.standard.double(forKey: Keys.kTax.rawValue)

        return value > 0 ? value : SettingsDefault.TaxDefault
    }

    func addValue(value: Double, key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
