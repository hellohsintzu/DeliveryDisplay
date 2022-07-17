//
//  MyDeliveryRouter.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation
import UIKit

protocol MyDeliveryRouterProtocol {
    func redirectToDeliveryDetail(nav: UINavigationController, model: MyDeliveryModel)
}

final class MyDeliveryRouter: MyDeliveryRouterProtocol {
    func redirectToDeliveryDetail(nav: UINavigationController, model: MyDeliveryModel) {
        let viewModel = DeliveryDetailViewModel(model: model)
        let viewController = DeliveryDetailViewController(viewModel: viewModel)
        viewController.title = Constants.DeliveryDetail.deliveryDetailsTitle
        nav.pushViewController(viewController, animated: true)
    }
}
