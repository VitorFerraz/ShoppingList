//
//  ViewConfigurator.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation
    
protocol ViewConfigurator: class {
    func setup()
    func addViewHierarchy()
    func setupConstraints()
}

extension ViewConfigurator {
    func setup() {
        addViewHierarchy()
        setupConstraints()
    }
}
