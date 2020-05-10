//
//  MainTabBarController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 05/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

struct TabController {
    var title: String
    var controller: UIViewController
}
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    var tabControllers: [TabController] {
        let buyItemsNavController = templateNavController(image: #imageLiteral(resourceName: "suitcase-icon"),rootViewController: BuyItemsListController())
        let buyAdjustmentsNavController = templateNavController(image: #imageLiteral(resourceName: "gear-icon"),rootViewController: BuyAdjustmentsViewController())
        let totalNavController = templateNavController(image: #imageLiteral(resourceName: "suitcase-icon"),rootViewController: TotalViewController())

        return [.init(title: "Compras", controller: buyItemsNavController),
                .init(title: "Ajustes", controller: buyAdjustmentsNavController),
                .init(title: "Total de Compra", controller:totalNavController)]
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        setupViewControllers()
        setupTabBarItemsNames()
    }

    func setupViewControllers() {
        viewControllers = tabControllers.map({$0.controller})
    }
    
    func setupTabBarItemsNames() {
        for (index, tab) in tabControllers.enumerated() {
            tabBar.items?[index].title = tab.title
        }
    }
    
    private func templateNavController(image: UIImage? = nil, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        return navController
    }
}
