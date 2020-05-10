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
        let stack = UIStackView(arrangedSubviews: [nameField,
                                                   imageButton,
                                                   purchaseStateStack,
                                                   cashStack,
                                                   saveButton])
        stack.spacing = 16
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
    }()

    private lazy var pickerState: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var pickerToolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapPickerCancel))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.didTapPickerDone))
        toolBar.setItems([cancel, leftSpace, done], animated: true)
        toolBar.isUserInteractionEnabled = true
        return toolBar
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

    private lazy var purchaseStateField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Estado da compra"
        field.inputView = pickerState
        field.delegate = self
        field.setContentCompressionResistancePriority(.required, for: .vertical)
        field.inputAccessoryView = pickerToolbar
        return field
    }()

    private let plusButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.addTarget(self, action: #selector(didTapAddState), for: .touchUpInside)
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
        guard
            let name = nameField.text,
            nameField.text != "",
            let image = imageButton.imageView?.image,
            let cashText = cashField.text,
            let price = Double(cashText) else {
                delegate?.showErrorAlert()
                return
        }

        delegate?.didTapSave(name: name, creditCardBuy: cardSwitch.isOn, photo: image, price: price)
    }

    @objc
    private func didTapCover() {
        delegate?.didTapCover()
    }

    @objc
    private func didTapPickerDone() {
        let index = pickerState.selectedRow(inComponent: 0)
        delegate?.didSelectPickerState(at: index)
        purchaseStateField.text = delegate?.pickerTitle(at: index)
        endEditing(true)
    }

    @objc
    private func didTapPickerCancel() {
        endEditing(true)
        pickerState.selectRow(delegate?.getSelectedPickerIndex() ?? 0, inComponent: 0, animated: false)
    }

    @objc
    private func didTapAddState() {
        delegate?.didTapAddState()
    }

    func set(product: Product?) {
        guard let product = product else { return }
        nameField.text = product.name
        purchaseStateField.text = product.state?.name
        cashField.text = "\(product.price)"
        cardSwitch.setOn(product.creditCardBuy, animated: false)
        saveButton.setTitle("Atualizar", for: .normal)
        if let imageData = product.photo {
            imageButton.setImage(UIImage(data: imageData), for: .normal)
        }
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

extension NewProductView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delegate?.pickerNumberOfRows() ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate?.pickerTitle(at: row)
    }
}

extension NewProductView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}


protocol NewProductViewDelegate {
    func didTapSave(name: String, creditCardBuy: Bool, photo: UIImage, price: Double)
    func didTapCover()
    func pickerNumberOfRows() -> Int
    func pickerTitle(at index: Int) -> String?
    func didSelectPickerState(at index: Int)
    func getSelectedPickerIndex() -> Int
    func showErrorAlert()
    func didTapAddState()
}
