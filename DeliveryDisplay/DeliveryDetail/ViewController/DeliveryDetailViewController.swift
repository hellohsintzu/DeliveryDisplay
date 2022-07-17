//
//  DeliveryDetailViewController.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import UIKit

final class DeliveryDetailViewController: UIViewController {
    private let viewModel: DeliveryDetailViewModelProtocol
    
    init(viewModel: DeliveryDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        self.navigationItem.title = Constants.DeliveryDetail.deliveryDetailsTitle
    }
}
