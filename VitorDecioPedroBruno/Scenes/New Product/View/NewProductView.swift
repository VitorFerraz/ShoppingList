//
//  NewProductView.swift
//  ShoppingList
//
//  Created by Decio Montanhani on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
import SwiftUI

final class NewProductView: UIView {

    var delegate: NewProductViewDelegate?

    // MARK: - Elements
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, imageButton, purchaseStateStack, cashStack, saveButton])
        stack.spacing = 16
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
    }()

    private let nameField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Nome do Produto"
        return field
    }()

    lazy var imageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "gift")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapCover), for: .touchUpInside)
        return button
    }()

    private lazy var purchaseStateStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [purchaseStateField, plusButton])
        stack.alignment = .trailing
        stack.spacing = 16
        stack.distribution = .fillProportionally
        return stack
    }()

    private let purchaseStateField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Estado da compra"
        field.setContentCompressionResistancePriority(.required, for: .vertical)
        return field
    }()

    private let plusButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        return button
    }()

    private lazy var cashStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cashField, cardStack])
        stack.spacing = 16
        return stack
    }()

    private let cashField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Valor (U$)"
        return field
    }()

    private lazy var cardStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cardLabel, cardSwitch])
        stack.spacing = 8
        return stack
    }()

    private let cardSwitch: UISwitch = {
        let check = UISwitch()
        return check
    }()

    private let cardLabel: UILabel = {
        let label = UILabel()
        label.text = "Cartão?"
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Cadastrar".uppercased(), for: .normal)

        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension NewProductView {
    @objc
    private func didTapSave() {
        delegate?.didTapSave()
    }

    @objc
    private func didTapCover() {
        print("clicou na imagem");
        delegate?.didTapConver()
    }
}

extension NewProductView: ViewConfigurator {
    func addViewHierarchy() {
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))

        imageButton.constrainHeight(250)
        saveButton.constrainHeight(60)
    }
}

protocol NewProductViewDelegate {
    func didTapSave()
    func didTapState()
    func didTapConver()
}
