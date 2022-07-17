//
//  MyDeliveryCoordinator.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import UIKit

final class MyDeliveryCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController

    init(navigationController :UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkClient = NetworkService()
        let service = MyDeliveryService(networkClient: networkClient)
        let viewModel = MyDeliveryViewModel(service: service)
        let viewController = MyDeliveryViewController(viewModel: viewModel)
        
        viewModel.didSelect = { [weak self] model in
            guard let self = self else { return }
            self.navigateToDeliveryDetailVC(model)
        }
        navigationController.setViewControllers([viewController], animated: true)
    }

    func navigateToDeliveryDetailVC(_ model: MyDeliveryModel) {
        let coordinator = DeliveryDetailCoordinator(model: model, nav: self.navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
