//
//  BuyAdjustmentsView.swift
//  ShoppingList
//
//  Created by Pedro Xudre on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation
import UIKit

class BuyAdjustmentsView : UIView {

    let quotationLabel: UILabel = {
        let label = UILabel()

        label.text = "Cotação do dólar (R$):"
        label.textAlignment = .right

        return label
    }()
    let taxLabel: UILabel = {
        let label = UILabel()

        label.text = "IOF (%):"
        label.textAlignment = .right

        return label
    }()

    let quotationInput: UITextField = {
        let field = UITextField()

        field.placeholder = "0.0"
        field.keyboardType = .decimalPad

        return field
    }()
    let taxInput: UITextField = {
        let field = UITextField()

        field.placeholder = "0.0"
        field.keyboardType = .decimalPad

        return field
    }()

    let sectionLabel: UILabel = {
        let label = UILabel()

        label.text = "Impostos por estado"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center

        return label
    }()

    lazy var statesTable: UITableView = {
        let table = UITableView()

        return table
    }()

    let addStateButton: UIButton = {
        let button = UIButton()

        button.setTitle("Adicionar estado", for: .normal)

        return button
    }()

    lazy var stackQuotation: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ quotationLabel, quotationInput ])

        return stack
    }()

    lazy var stackTax: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ taxLabel, taxInput ])

        return stack
    }()
}

extension BuyAdjustmentsView : ViewConfigurator {
    
    func addViewHierarchy() {
        addSubview(stackQuotation)
        addSubview(stackTax)
        addSubview(sectionLabel)
        addSubview(statesTable)
        addSubview(addStateButton)
    }

    func setupConstraints() {
        stackQuotation.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: safeAreaLayoutGuide.trailingAnchor)

        stackTax.anchor(top: stackQuotation.bottomAnchor,
                        leading: safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: safeAreaLayoutGuide.trailingAnchor)

        sectionLabel.anchor(top: stackTax.bottomAnchor,
                            leading: safeAreaLayoutGuide.leadingAnchor,
                            bottom: nil,
                            trailing: safeAreaLayoutGuide.trailingAnchor)

        statesTable.anchor(top: sectionLabel.bottomAnchor,
                           leading: safeAreaLayoutGuide.leadingAnchor,
                           bottom: addStateButton.topAnchor,
                           trailing: safeAreaLayoutGuide.trailingAnchor)

        addStateButton.anchor(top: nil,
                              leading: nil,
                              bottom: bottomAnchor,
                              trailing: leadingAnchor)
    }

}
