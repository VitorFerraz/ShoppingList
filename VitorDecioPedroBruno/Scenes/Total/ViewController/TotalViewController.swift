//
//  TotalViewController.swift
//  ShoppingList
//
//  Created by Bruno Cortez on 5/3/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

// MARK: - Class
class TotalViewController: UIViewController {
    
    // MARK: - Properties
    let totalView = TotalView()
    let viewModel = TotalViewModel()

    // MARK: - Superclass Overwriting Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateTotals()
    }
    
    func updateTotals() {
        totalView.lbTotalDollarValue.text = viewModel.getTotalDollar()
        totalView.lbTotalReaisValue.text = viewModel.getTotalReais()
    }
}

// MARK: - Extensions
extension TotalViewController: ViewConfigurator {
 
    func setupConstraints() {
        totalView.fillSuperview(padding: .init(top: 50, left: 0, bottom: 0, right: 0))
    }
    
    func addViewHierarchy() {
        view.addSubview(totalView)
    }
}

// MARK: - Live Render
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct TotalRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return TotalViewController().view!
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct TotalViewController_Preview: PreviewProvider {
    static var previews: some View {
        TotalRepresentable()
    }
}
#endif
