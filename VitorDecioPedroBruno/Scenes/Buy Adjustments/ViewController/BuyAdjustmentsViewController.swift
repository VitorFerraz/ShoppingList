//
//  BuyAdjustmentsViewController.swift
//  ShoppingList
//
//  Created by Pedro Xudre on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

class BuyAdjustmentsViewController: UIViewController {

    private let data = CoredataManager()
    private var states: [State] = []
    private let adjustmentView = BuyAdjustmentsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()

        loadPreferences()
    }

    func loadPreferences() {
        adjustmentView.quotationInput.text = "\(SettingsManager.shared.dollarValue)"
        adjustmentView.taxInput.text = "\(SettingsManager.shared.taxValue)"
    }

    func loadData() {
        do {
            states = try data.fetchStates()

            adjustmentView.statesTable.reloadData()
            adjustmentView.statesTable.backgroundView = !states.isEmpty ? nil : adjustmentView.emptyMessageLabel
        } catch {
            print(error)
        }
    }

    @objc func tapAddState(sender: UIButton) {
        openStateModal(state: nil)
    }

    func openStateModal(state: State?) {
        let modalTitle = state == nil ? "Adicionar estado" : "Editar estado"
        let modalConfirm = state == nil ? "Adicionar" : "Atualizar"
        let modal = UIAlertController(
            title: modalTitle,
            message: nil,
            preferredStyle: .alert)

        modal.addTextField { (field) in
            field.text = state?.name
            field.placeholder = "Nome do estado"
        }

        modal.addTextField { (field) in
            if (state != nil) {
                field.text = "\(state?.tax ?? 0)"
            }

            field.placeholder = "Imposto"
            field.keyboardType = .decimalPad
        }

        modal.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (act) in
            //modal.dismiss(animated: true, completion: nil)
        }))

        modal.addAction(UIAlertAction(title: modalConfirm, style: .default, handler: { (act) in
            let stateName = modal.textFields![0].text!
            let taxValue = modal.textFields![1].text!

            if (stateName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || taxValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) { return }

            self.addState(name: stateName, tax: taxValue.doubleValue, state: state) {
            }
        }))

        present(modal, animated: true, completion: nil)
    }

    func addState(name: String, tax: Double, state: State?, completion: (() -> Void)? = nil) {
        do {
            if (state == nil) {
                try data.newState(name: name, tax: tax)
            } else {
                state?.name = name
                state?.tax = tax

                try data.save()
            }

            loadData()

            if (completion != nil) {
                completion!()
            }
        } catch {
            print(error)
        }
    }

    func removeState(state: State, completion: (() -> Void)? = nil) {
        do {
            data.delete(item: state)

            try data.save()

            loadData()

            if (completion != nil) {
                completion!()
            }
        } catch {
            print(error)
        }
    }
}

extension BuyAdjustmentsViewController : ViewConfigurator {

    func addViewHierarchy() {
        adjustmentView.quotationInput.delegate = self
        adjustmentView.taxInput.delegate = self
        adjustmentView.statesTable.dataSource = self
        adjustmentView.statesTable.delegate = self
        adjustmentView.addStateButton.addTarget(self, action: #selector(tapAddState), for: .touchUpInside)

        view.addSubview(adjustmentView)
    }

    func setupConstraints() {
        adjustmentView.fillSuperview(padding: .init(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
            ))
    }

}

extension BuyAdjustmentsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableId = "stateTax"
        var cell = tableView.dequeueReusableCell(withIdentifier: reusableId)

        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: reusableId)

            cell?.detailTextLabel?.textColor = .red
        }

        let state = states[indexPath.row]

        cell?.textLabel?.text = state.name
        cell?.detailTextLabel?.text = "\(state.tax)"

        return cell!
    }
}

extension BuyAdjustmentsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let state = states[indexPath.row]

            removeState(state: state)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = states[indexPath.row]

        openStateModal(state: state)
    }
}

extension BuyAdjustmentsViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = textField.accessibilityIdentifier,
            let key = Keys(rawValue: identifier) else { return }
        let value = textField.text?.doubleValue ?? 0.0
        SettingsManager.shared.addValue(value: value, key: key)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct BuyAdjustmentsViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return BuyAdjustmentsViewController().view!
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct BuyAdjustmentsViewController_Preview: PreviewProvider {
    static var previews: some View {
        BuyAdjustmentsViewRepresentable()
    }
}
#endif

