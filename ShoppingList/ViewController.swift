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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        
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
