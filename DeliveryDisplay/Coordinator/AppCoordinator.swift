//
//  AppCoordinator.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let window : UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let coordinator = MyDeliveryCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }
}
