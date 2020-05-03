//
//  ShoppingListTests.swift
//  ShoppingListTests
//
//  Created by vitor.ferrazvarela on 03/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import XCTest
import CoreData

@testable import ShoppingList

class ShoppingListTests: XCTestCase {
    var manager: CoredataManager!
    override func setUp() {
        super.setUp()
        manager = CoredataManager.init()
    }
    
    override func tearDown() {
        super.tearDown()
        testDeleteAll()
        manager = nil
    }
    func testCreateItem() {
        createItem()
    }
    
    func testRetriveItems() {
        createItem()
        let objects = manager.fetchObjects()
        XCTAssertEqual(objects.count, 1)
    }
    
    func testdeleteItem() {
        createItem()
        let objects = manager.fetchObjects()
        let count = objects.count
        manager.delete(item: objects.first! )
        let newCount = manager.fetchObjects().count
        XCTAssertNotEqual(count, newCount - 1)
    }
    
    func testDeleteAll() {
        deleteAll()
    }
    
    func createItem() {
        let item = Teste(context: manager.context)
        item.title = UUID().uuidString
        do {
            try manager.save()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        do {
            try manager.deleteAll(item: Teste.self)
            let objects = manager.fetchObjects()
            XCTAssertEqual(objects.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

