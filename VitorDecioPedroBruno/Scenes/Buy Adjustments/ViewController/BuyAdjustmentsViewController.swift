//
//  BuyAdjustmentsViewController.swift
//  ShoppingList
//
//  Created by Pedro Xudre on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class BuyAdjustmentsViewController: UIViewController {

    private let adjustmentView = BuyAdjustmentsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        setupPreferences()

        hideKeyboardWhenTappedAround()
    }

    func setupPreferences() {
        let userPref = UserDefaults()

        if let value = userPref.string(forKey: adjustmentView.quotationInput.accessibilityIdentifier!) {
            adjustmentView.quotationInput.text = value
        }

        if let value = userPref.string(forKey: adjustmentView.taxInput.accessibilityIdentifier!) {
            adjustmentView.taxInput.text = value
        }
    }

    @objc func openStateModal(sender: UIButton) {
        let modal = UIAlertController(
            title: "Adicionar estado",
            message: nil,
            preferredStyle: .alert)

        modal.addTextField { (field) in
            field.placeholder = "Nome do estado"
        }

        modal.addTextField { (field) in
            field.placeholder = "Imposto"
            field.keyboardType = .decimalPad
        }

        modal.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (act) in
            //modal.dismiss(animated: true, completion: nil)
        }))

        modal.addAction(UIAlertAction(title: "Cadastrar", style: .destructive, handler: { (act) in
            let stateName = modal.textFields![0].text!
            let taxValue = modal.textFields![1].text!

            if (stateName.isEmpty || taxValue.isEmpty) { return }

            self.addState(name: stateName, tax: taxValue.doubleValue) {
            }
        }))

        present(modal, animated: true, completion: nil)
    }

    func addState(name: String, tax: Double, completion: (() -> Void)? = nil) {
        // TODO data sync

        if (completion != nil) {
            completion!()
        }
    }
}

extension BuyAdjustmentsViewController : ViewConfigurator {

    func addViewHierarchy() {
        adjustmentView.quotationInput.delegate = self
        adjustmentView.taxInput.delegate = self
        adjustmentView.statesTable.delegate = self
        adjustmentView.addStateButton.addTarget(self, action: #selector(openStateModal), for: .touchUpInside)

        view.addSubview(adjustmentView)
    }

    func setupConstraints() {
        adjustmentView.fillSuperview(padding: .init(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
            ))
    }

}

extension BuyAdjustmentsViewController : UITableViewDelegate {

}

extension BuyAdjustmentsViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let userPref = UserDefaults()

        userPref.set(textField.text, forKey: textField.accessibilityIdentifier!)

        userPref.synchronize()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct BuyAdjustmentsViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return BuyAdjustmentsViewController().view!
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct BuyAdjustmentsViewController_Preview: PreviewProvider {
    static var previews: some View {
        BuyAdjustmentsViewRepresentable()
    }
}
#endif

