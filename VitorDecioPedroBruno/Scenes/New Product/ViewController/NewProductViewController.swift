//
//  NewProductViewController.swift
//  ShoppingList
//
//  Created by Decio Montanhani on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

final class NewProductViewController: UIViewController, CameraAlertControllerDelegate {

    var coredataManager = CoredataManager()

    private var states = [State]()
    private var selectedState: State?
    private var isEditingProduct = false
    private var editedProduct: Product? = nil
    private var didSelectImage: Bool = false

    func presentFromAlert(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func didSelectedImage(_ image: UIImage) {
        didSelectImage = true
        customView.imageButton.setImage(image, for: .normal)
    }

    func setEditingState(product: Product? = nil) {
        isEditingProduct = true
        didSelectImage = true
        selectedState = product?.state
        editedProduct = product
        title = "Editar Produto"
        customView.set(product: product)
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
        if !isEditingProduct {
            title = "Cadastrar Produto"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStates()

    }

    override func loadView() {
        view = customView
    }

    private func fetchStates() {
        do {
            states = try coredataManager.fetchStates()
        } catch {
            print("error trying to fetch states")
        }

    }
}

extension NewProductViewController: NewProductViewDelegate {
    func didTapAddState() {
        let controller = BuyAdjustmentsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Erro ao salvar", message: "Preencha todos os dados corretamente para continuar", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default))

        navigationController?.present(alert, animated: true)
    }

    func didSelectPickerState(at index: Int) {
        if states.isEmpty {
            return
        }
        selectedState = states[index]
    }

    func getSelectedPickerIndex() -> Int {
        guard let state = selectedState else { return 0 }
        return states.firstIndex(of: state) ?? 0
    }

    func pickerNumberOfRows() -> Int {
        return states.count
    }

    func pickerTitle(at index: Int) -> String? {
        if states.isEmpty {
            return ""
        }
        return states[index].name
    }

    func didTapCover() {
        let alert = cameraController.alert
        self.present(alert, animated: true, completion: nil)
    }

    func didTapSave(name: String, creditCardBuy: Bool, photo: UIImage, price: Double) {
        guard
            didSelectImage,
            let state = selectedState else {
            showErrorAlert()
            return
        }
        do {
            if isEditingProduct {
                editedProduct?.name = name
                editedProduct?.creditCardBuy = creditCardBuy
                editedProduct?.photo = photo.pngData()
                editedProduct?.price = price
                editedProduct?.state = selectedState
                try coredataManager.save()

            } else {
                try coredataManager.newProduct(name: name,
                                               creditCardBuy: creditCardBuy,
                                               photo: photo,
                                               price: price,
                                               state: state)
            }
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
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
