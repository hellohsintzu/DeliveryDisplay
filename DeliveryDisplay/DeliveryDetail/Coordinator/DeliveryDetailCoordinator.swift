//
//  DeliveryDetailCoordinator.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import UIKit

final class DeliveryDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: MyDeliveryCoordinator?
    private let navigationController: UINavigationController
    private let model: MyDeliveryModel
    
    init(model: MyDeliveryModel, nav :UINavigationController) {
        self.model = model
        self.navigationController = nav
    }
    
    func start() {
        let viewModel = DeliveryDetailViewModel(model: model)
        let viewController = DeliveryDetailViewController(viewModel: viewModel)
        viewController.title = Constants.DeliveryDetail.deliveryDetailsTitle
        viewModel.didTapBackBtn = { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.childDidFinish(childCoordinator: self)
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
