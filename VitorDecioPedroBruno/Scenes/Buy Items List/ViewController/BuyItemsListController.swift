//
//  BuyItemsListController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class BuyItemsListController: GenericTableViewController<ProductCell, Product> {
    
    let viewModel = BuyItemsListViewModel()
    var coredataManager = CoredataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = viewModel.getBuyItems()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        let newProductVc = NewProductViewController()
        newProductVc.setEditingState(true, product: product)
        navigationController?.show(newProductVc, sender: nil)
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
