//
//  TotalView.swift
//  ShoppingList
//
//  Created by Bruno Cortez on 5/3/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Class
class TotalView: UIView {
    
    // MARK: - Properties
    let lbTotalDollarTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Total em U$:"
        label.textColor = .black
        return label
    }()
    
    let lbTotalDollarValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "0,00"
        label.textColor = .red
        return label
    }()
    
    let lbTotalReaisTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Total em R$:"
        label.textColor = .black
        return label
    }()
    
    let lbTotalReaisValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "0,00"
        label.textColor = .green
        return label
    }()
    
    lazy var stDollar: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [lbTotalDollarTitle, lbTotalDollarValue])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    lazy var stReais: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [lbTotalReaisTitle, lbTotalReaisValue])
       stack.axis = .vertical
       stack.spacing = 16
       return stack
    }()
    
    // MARK: - Superclass Overwriting Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extenions
extension TotalView: ViewConfigurator {
    func setupConstraints() {
        
        // stack dollar
        stDollar.anchor(top: safeAreaLayoutGuide.topAnchor,
                        leading: leadingAnchor,
                        bottom: nil,
                        trailing: trailingAnchor,
                        padding: .init(top: 50,
                                       left: 50,
                                       bottom: 0,
                                       right: 50),
                        size: .init(width: 0, height: 0))
        
        // stack reais
        stReais.anchor(top: stDollar.bottomAnchor,
                       leading: leadingAnchor,
                       bottom: nil,
                       trailing: trailingAnchor,
                       padding: .init(top: 70,
                                      left: 50,
                                      bottom: 0,
                                      right: 50),
                       size: .init(width: 0, height: 0))
        
    }
    
    func addViewHierarchy() {
        addSubview(stDollar)
        addSubview(stReais)
    }
}

