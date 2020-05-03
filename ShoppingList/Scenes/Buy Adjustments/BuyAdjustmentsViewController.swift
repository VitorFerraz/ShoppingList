//
//  BuyAdjustmentsViewController.swift
//  ShoppingList
//
//  Created by Pedro Xudre on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class BuyAdjustmentsViewController: UIViewController {

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
        label.textAlignment = .center

        return label
    }()

    lazy var statesTable: UITableView = {
        let table = UITableView()

        table.delegate = self

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

extension BuyAdjustmentsViewController : ViewConfigurator {

    func addViewHierarchy() {
        view.addSubview(stackQuotation)
        view.addSubview(stackTax)
        view.addSubview(sectionLabel)
        view.addSubview(statesTable)
        view.addSubview(addStateButton)
    }

    func setupConstraints() {

    }
    
}

extension BuyAdjustmentsViewController : UITableViewDelegate {

}
