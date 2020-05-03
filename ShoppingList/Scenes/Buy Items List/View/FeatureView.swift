//
//  FeatureView.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class FeatureView: UIView {
    let label = UILabel()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        label.text = "custom"
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeatureView: ViewConfigurator {
    func setupConstraints() {
        label.fillSuperview()
    }
    
    func addViewHierarchy() {
        addSubview(label)
    }
    
    
}
