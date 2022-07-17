//
//  DeliveryDetailViewModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation

protocol DeliveryDetailViewModelProtocol {
    var senderLabelTitle: String { get }
    var receiverLabelTitle: String { get }
    var imageURLString: String { get }
    var deliveryFeeString: String { get }
}

final class DeliveryDetailViewModel {
    private let deliveryDetail: MyDeliveryModel
    
    init(model: MyDeliveryModel) {
        deliveryDetail = model
    }
}

extension DeliveryDetailViewModel: DeliveryDetailViewModelProtocol {
    var senderLabelTitle: String {
        return deliveryDetail.senderTitle
    }
    
    var receiverLabelTitle: String {
        return deliveryDetail.receiverTitle
    }
    
    var imageURLString: String {
        return deliveryDetail.imageURLString
    }
    
    var deliveryFeeString: String {
        return "\(Constants.MyDelivery.feeLabel)\(deliveryDetail.feeTitle)"
    }
}
