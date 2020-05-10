//
//  CoreDataTests.swift
//  VitorDecioPedroBrunoTests
//
//  Created by vitor.ferrazvarela on 10/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import XCTest
import CoreData

@testable import ComprasUSA

class CoreDataTests: XCTestCase {
    var manager: CoredataManager!
    override func setUp() {
        super.setUp()
        manager = CoredataManager.init()
    }
    
    override func tearDown() {
        super.tearDown()
        manager = nil
    }

}
