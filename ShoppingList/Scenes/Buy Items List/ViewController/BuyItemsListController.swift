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
    }
}
