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
    var isFavorite: Bool { get set }
    
    func viewDidDisappear()
}

final class DeliveryDetailViewModel {
    private let deliveryDetail: MyDeliveryModel
    private let userDefaults = UserDefaults()
    var didTapBackBtn: (() -> Void)?
    
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
    
    var isFavorite: Bool {
        get {
            guard let isFav = userDefaults.value(forKey: deliveryDetail.id) as? Bool else {
                return false
            }
            return isFav
        }
        
        set {
            userDefaults.setValue(newValue, forKey: deliveryDetail.id)
        }
    }
    
    func viewDidDisappear() {
        self.didTapBackBtn?()
    }
}
