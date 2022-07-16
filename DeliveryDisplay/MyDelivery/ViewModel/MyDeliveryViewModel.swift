//
//  MyDeliveryViewModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

protocol MyDeliveryViewModelProtocol {
    // TableView
    var numberOfRows: Int { get }
    
    // API call
    func fetchDeliveryList(completionHandler: @escaping () -> Void)
}

final class MyDeliveryViewModel {
    private let service: MyDeliveryServiceProtocol
    private var deliveryData: [DeliveryDetails]?
    
    init(service: MyDeliveryServiceProtocol) {
        self.service = service
    }
    
}

extension MyDeliveryViewModel: MyDeliveryViewModelProtocol {
    var numberOfRows: Int {
        return 0
    }
    
    func fetchDeliveryList(completionHandler: @escaping () -> Void) {
        service.fetchListOfDeliveries { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.deliveryData = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
