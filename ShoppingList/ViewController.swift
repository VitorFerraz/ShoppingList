//
//  ViewController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let label = UILabel()
    let teste = FeatureView()
    let button = UIButton(type: .contactAdd)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setup()
        
    }
}

extension ViewController: ViewConfigurator {
    
    func addViewHierarchy() {
        label.text = "teste"
        view.addSubview(label)
        view.addSubview(teste)
        
    }
    
    func setupConstraints() {
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        teste.fillSuperview(padding: .init(top: 50, left: 0, bottom: 0, right: 0))
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return ViewController().view!
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewRepresentable()
    }
}
#endif
