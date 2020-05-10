//
//  BuyItemsListController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class BuyItemsListController: GenericTableViewController<ProductCell, Product> {
    var coredataManager = CoredataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let procut = Product(context: coredataManager.context)
        procut.name = "teste"
        try? coredataManager.save()
        items = [procut]
        setupNavigation()
    }
    
    private func setupNavigation() {
        title = "Lista de Compras"
        let addProductButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProduct))
        navigationItem.rightBarButtonItem = addProductButton
    }
    
    @objc private func showAddProduct() {
        let newProductVc = NewProductViewController()
        navigationController?.show(newProductVc, sender: nil)
    }
}
