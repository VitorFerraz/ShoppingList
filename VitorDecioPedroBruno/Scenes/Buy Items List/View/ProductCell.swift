//
//  ProductCell.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 08/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
class ProductCell: GenericCell<Product>, ViewConfigurator {
    lazy var stack: UIStackView = {
        let textStack = UIStackView(arrangedSubviews: [nameLabel,priceLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        let imageStack = UIStackView(arrangedSubviews: [productImage])
        imageStack.alignment = .center
        let stack = UIStackView(arrangedSubviews: [imageStack,textStack])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        
        return stack
    }()
    
    var productImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gift")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.constrainWidth(80)
        iv.constrainHeight(80)
        iv.layer.cornerRadius = 80/2
        return iv
        
    }()
    override var item: Product! {
        didSet {
            nameLabel.text = item.name
            priceLabel.text = item.price.dollarCurrencyFormat
            guard let imageData = item.photo else { return }
            productImage.image = UIImage(data: imageData)
        }
    }
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewHierarchy() {
        self.addSubview(stack)
    }
    
    func setupConstraints() {
        stack.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
}
