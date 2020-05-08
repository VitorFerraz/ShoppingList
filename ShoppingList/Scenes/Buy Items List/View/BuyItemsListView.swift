//
//  FeatureView.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

// MARK: - Class
class BuyItemsListView: UIView {
    
    // MARK: - Properties
    let lbEmpty: UILabel = {
       let label = UILabel()
        label.text = "Sua lista está vazia!"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let tableView = UITableView()
    
    // MARK: - Superclass Overwriting Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions
extension BuyItemsListView: ViewConfigurator {
    func setupConstraints() {
        tableView.fillSuperview()
        lbEmpty.fillSuperview()
    }
    
    func addViewHierarchy() {
        addSubview(tableView)
        addSubview(lbEmpty)
    }
    
    
}
