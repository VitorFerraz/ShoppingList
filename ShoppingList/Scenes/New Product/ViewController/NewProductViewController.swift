//
//  NewProductViewController.swift
//  ShoppingList
//
//  Created by Decio Montanhani on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

final class NewProductViewController: UIViewController, CameraAlertControllerDelegate {
    func presentFromAlert(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func didSelectedImage(_ image: UIImage) {
        customView.imageButton.setImage(image, for: .normal)

    }
    
    let cameraController = CameraAlertController()
    private lazy var customView: NewProductView = {
        let view = NewProductView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraController.delegate = self
    }

    override func loadView() {
        view = customView
    }
}

extension NewProductViewController: NewProductViewDelegate {
    func didTapConver() {
        let alert = cameraController.buildAlert()
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapState() {
        print("Chamar a tela do Pedro")
    }

    func didTapSave() {
        print("clicou para salvar o produto")
        // cadastrar produto
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct NewProductViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return NewProductViewController().view!
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct NewProductViewController_Preview: PreviewProvider {
    static var previews: some View {
        NewProductViewRepresentable()
    }
}
#endif
