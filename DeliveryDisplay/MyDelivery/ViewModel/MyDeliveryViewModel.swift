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
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryCellModel
    
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
    
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryCellModel {
        let cModel = MyDeliveryCellModel(senderTitle: self.deliveryData?[indexPath.row].route?.start ?? "",
                                         receiverTitle: self.deliveryData?[indexPath.row].route?.end ?? "",
                                         feeTitle: self.generateDeliveryFee(indexPath),
                                         imageURLString: self.deliveryData?[indexPath.row].goodsPicture ?? "")
        return cModel
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

private extension MyDeliveryViewModel {
    func generateDeliveryFee(_ indexPath: IndexPath) -> String {
        guard var deliveryFee = self.deliveryData?[indexPath.row].deliveryFee,
              var surcharge = self.deliveryData?[indexPath.row].surcharge else { return "" }
        deliveryFee.removeFirst()
        surcharge.removeFirst()
        let deliveryFeeFloat = Float(deliveryFee) ?? 0.0
        let surchargeFloat = Float(surcharge) ?? 0.0
        let fee = deliveryFeeFloat + surchargeFloat
        return String(format: "%.2f", fee)
    }
}