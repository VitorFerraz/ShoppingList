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
    }

}

extension BuyAdjustmentsViewController : ViewConfigurator {

    func addViewHierarchy() {
        adjustmentView.statesTable.delegate = self

        view.addSubview(adjustmentView)
    }

    func setupConstraints() {
        adjustmentView.fillSuperview()
    }
    
}

extension BuyAdjustmentsViewController : UITableViewDelegate {

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
