//
//  MyDeliveryRouter.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation
import UIKit

protocol MyDeliveryRouterProtocol {
    func redirectToDeliveryDetail(nav: UINavigationController)
}

final class MyDeliveryRouter: MyDeliveryRouterProtocol {
    func redirectToDeliveryDetail(nav: UINavigationController) {
        let viewModel = DeliveryDetailViewModel()
        let viewController = DeliveryDetailViewController(viewModel: viewModel)
        nav.pushViewController(viewController, animated: true)
    }
}
