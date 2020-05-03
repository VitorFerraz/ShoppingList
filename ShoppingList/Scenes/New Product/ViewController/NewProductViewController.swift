//
//  NewProductViewController.swift
//  ShoppingList
//
//  Created by Decio Montanhani on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

final class NewProductViewController: UIViewController {

    private lazy var customView: NewProductView = {
        let view = NewProductView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = customView
    }
}

extension NewProductViewController: NewProductViewDelegate {
    func didTapState() {
        print("Chamar a tela do Pedro")
    }

    func didTapSave() {
        print("clicou para salvar o produto")
        // cadastrar produto
    }
}
