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
    func cellAt(_ indexPath: IndexPath) -> DeliveryDetails?
    
    // API call
    func fetchDeliveryList(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void)
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
        return self.deliveryData?.count ?? 0
    }
    
    func cellAt(_ indexPath: IndexPath) -> DeliveryDetails? {
        return deliveryData?[indexPath.row]
    }
    
    func fetchDeliveryList(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        service.fetchListOfDeliveries { [weak self] result in
            switch result {
            case .success(let data):
                self?.deliveryData = data
                completionHandler(true, nil)
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
}
