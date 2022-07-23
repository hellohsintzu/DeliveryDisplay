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
    private let selectedIndexPath: IndexPath
    
    init(model: MyDeliveryModel, nav :UINavigationController, selectedIndexPath: IndexPath) {
        self.model = model
        self.navigationController = nav
        self.selectedIndexPath = selectedIndexPath
    }
    
    func start() {
        let viewModel = DeliveryDetailViewModel(model: model, selectedIndexPath: selectedIndexPath)
        let viewController = DeliveryDetailViewController(viewModel: viewModel)
        viewController.title = Constants.DeliveryDetail.deliveryDetailsTitle
        viewModel.didTapBackBtn = { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.childDidFinish(childCoordinator: self)
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
