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
}

extension BuyAdjustmentsViewController : ViewConfigurator {

    func addViewHierarchy() {
        adjustmentView.quotationInput.delegate = self
        adjustmentView.taxInput.delegate = self
        adjustmentView.statesTable.delegate = self

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

