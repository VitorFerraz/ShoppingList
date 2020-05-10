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
