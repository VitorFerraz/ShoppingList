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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        field.accessibilityIdentifier = Keys.kDollar.rawValue
        field.placeholder = "0.0"
        field.keyboardType = .decimalPad
        field.borderStyle = .roundedRect
        field.textAlignment = .right

        return field
    }()
    let taxInput: UITextField = {
        let field = UITextField()

        field.accessibilityIdentifier = Keys.kTax.rawValue
        field.placeholder = "0.0"
        field.keyboardType = .decimalPad
        field.borderStyle = .roundedRect
        field.textAlignment = .right

        return field
    }()

    let sectionLabel: UILabel = {
        let label = UILabel()

        label.text = "Impostos por estado"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center

        return label
    }()

    let emptyMessageLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Lista de estados vazia."
        label.textAlignment = .center

        return label
    }()

    lazy var statesTable: UITableView = {
        let table = UITableView()

        table.tableFooterView = UIView()

        return table
    }()

    let addStateButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("Adicionar estado", for: .normal)

        return button
    }()

    lazy var stackQuotation: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ quotationLabel, quotationInput ])

        stack.spacing = 16

        return stack
    }()

    lazy var stackTax: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ taxLabel, taxInput ])

        stack.spacing = 16

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
        quotationInput.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 0))

        taxInput.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 0))

        stackQuotation.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 50,
                                             left: 16,
                                             bottom: 0,
                                             right: 16))

        stackTax.anchor(top: stackQuotation.bottomAnchor,
                        leading: safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: safeAreaLayoutGuide.trailingAnchor,
                        padding: .init(top: 10,
                                       left: 16,
                                       bottom: 0,
                                       right: 16))

        sectionLabel.anchor(top: stackTax.bottomAnchor,
                            leading: safeAreaLayoutGuide.leadingAnchor,
                            bottom: nil,
                            trailing: safeAreaLayoutGuide.trailingAnchor,
                            padding: .init(top: 30,
                                           left: 0,
                                           bottom: 30,
                                           right: 0))

        statesTable.anchor(top: sectionLabel.bottomAnchor,
                           leading: safeAreaLayoutGuide.leadingAnchor,
                           bottom: addStateButton.topAnchor,
                           trailing: safeAreaLayoutGuide.trailingAnchor,
                           padding: .init(top: 0,
                                          left: 0,
                                          bottom: 20,
                                          right: 0))

        addStateButton.anchor(top: nil,
                              leading: nil,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              trailing: safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 0,
                                             left: 0,
                                             bottom: 20,
                                             right: 16))
    }

}
