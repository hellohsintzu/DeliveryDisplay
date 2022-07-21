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
    private var deliveryDetail: MyDeliveryModel
    private let moc = CoreDataManager.shared
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
        return "\(Constants.MyDelivery.feeLabel)\(generateDeliveryFee())"
    }
    
    var isFavorite: Bool {
        get {
            deliveryDetail.isFavorite
        }
        
        set {
            deliveryDetail.isFavorite = newValue
        }
    }
    
    func viewDidDisappear() {
        moc.saveContext()
        self.didTapBackBtn?()
    }
}

private extension DeliveryDetailViewModel {
    func generateDeliveryFee() -> String {
        var deliveryFee = deliveryDetail.deliveryFee
        var surcharge = deliveryDetail.surcharge
        guard !deliveryFee.isEmpty, !surcharge.isEmpty  else { return "" }
        deliveryFee.removeFirst()
        surcharge.removeFirst()
        let deliveryFeeFloat = Float(deliveryFee) ?? 0.0
        let surchargeFloat = Float(surcharge) ?? 0.0
        let fee = deliveryFeeFloat + surchargeFloat
        return String(format: "%.2f", fee)
    }
}
