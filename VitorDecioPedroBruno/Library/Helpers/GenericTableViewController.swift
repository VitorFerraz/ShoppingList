//
//  GenericTableViewController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 08/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
class GenericTableViewController<T: GenericCell<U>, U>: UITableViewController {
    
    /// An array of U objects this list will render. When using items.append, you still need to manually call reloadData.
    var items = [U]() {
        didSet {
            reloadData()
        }
    }
    lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = emptyTextMessage
        label.textAlignment = .center
        return label
    }()
    var emptyTextMessage = "Sua lista está vazia!"
    
    fileprivate let cellId = String(describing: U.self)
    
    /// Return an estimated height for proper indexPath using systemLayoutSizeFitting.
    func estimatedCellHeight(for indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let cell = T()
        let largeHeight: CGFloat = 1000
        cell.frame = .init(x: 0, y: 0, width: cellWidth, height: largeHeight)
        cell.item = items[indexPath.item]
        cell.layoutIfNeeded()
        
        return cell.systemLayoutSizeFitting(.init(width: cellWidth, height: largeHeight)).height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemBackground
        tableView.tableFooterView = UIView()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.backgroundView = self.items.isEmpty ? self.emptyMessageLabel : nil
        }
    }
    /// ListHeaderController automatically dequeues your T cell and sets the correct item object on it.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? T else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        cell.parentController = self
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
}
