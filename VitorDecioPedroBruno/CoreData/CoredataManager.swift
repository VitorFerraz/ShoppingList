//
//  CoredataManager.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
import CoreData

class CoredataManager {
    
    private var appDelegate: AppDelegate {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate
        } else {
            fatalError("Error to return AppDelegate")
        }
    }
    
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func delete<U>(item: U)  where U: NSManagedObject  {
        context.delete(item)
    }
    
    func deleteAll<U>(item: U) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: item.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
    
    func save() throws {
        try context.save()
    }
    
    func fetchProducts() throws -> [Product] {
        let items = try context.fetchObjects(Product.self)
        return items
    }
    
    func fetchStates() throws -> [State] {
        let items = try context.fetchObjects(State.self)
        return items
    }
    
    func newProduct(name: String,
                   creditCardBuy: Bool,
                   photo: UIImage,
                   price: Double,
                   state: State) throws {
        let product = Product(context: context)
        product.name = name
        product.creditCardBuy = creditCardBuy
        product.photo = photo.pngData()
        product.price = price
        product.state = state
        try save()
    }
    
    func newState(name: String, tax: Double) throws {
        let state = State(context: context)
        state.name = name
        state.tax = tax
        try save()
    }
    
}

extension CoredataManager {
    private func createStates() {
        try? newState(name: "XPTO", tax: 10.0)
        try? newState(name: "XPTO2", tax: 12.0)
        
    }
    func createFakeData() {
        try? deleteAll(item: State.self)
        try? deleteAll(item: Product.self)

        createStates()
        let states = try? fetchStates()
        states?.forEach({ (state) in
            try? newProduct(name: "Teste", creditCardBuy: true, photo: #imageLiteral(resourceName: "gift"), price: 10.0, state: state)
        })
    }
}
