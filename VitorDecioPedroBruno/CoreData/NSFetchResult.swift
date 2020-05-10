//
//  NSFetchResult.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext{
    func fetchObjects <T: NSManagedObject>(_ entityClass:T.Type,
                       sortBy: [NSSortDescriptor]? = nil,
                       predicate: NSPredicate? = nil) throws -> [T] {

        let request: NSFetchRequest<T>
        if #available(iOS 10.0, *) {
            request = entityClass.fetchRequest() as! NSFetchRequest<T>
        } else {
            let entityName = String(describing: entityClass)
            request = NSFetchRequest(entityName: entityName)
        }

        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortBy
        let fetchedResult = try self.fetch(request)
        return fetchedResult
    }
}
