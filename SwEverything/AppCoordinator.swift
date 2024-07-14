//
//  AppCoordinator.swift
//  SwEverything
//
//  Created by ilya on 07.07.2024.
//

import Foundation
import UIKit

class AppCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func navigateToMesssagesScreen() {
        let viewController = MessagesViewController()
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func logout() {
        let viewController = ViewController()
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }

}
