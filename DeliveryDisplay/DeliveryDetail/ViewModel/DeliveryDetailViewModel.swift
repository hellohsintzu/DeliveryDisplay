//
//  DeliveryDetailViewModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation
import RealmSwift

protocol DeliveryDetailViewModelProtocol {
    var senderLabelTitle: String { get }
    var receiverLabelTitle: String { get }
    var imageURLString: String { get }
    var deliveryFeeString: String { get }
    var isFavorite: Bool { get set }
    
    func viewWillDisappear()
    func viewDidDisappear()
}

final class DeliveryDetailViewModel {
    private var deliveryDetail: MyDeliveryModel
    private var selectedIndexPath: IndexPath
    var didTapBackBtn: (() -> Void)?
    
    init(model: MyDeliveryModel, selectedIndexPath: IndexPath) {
        self.deliveryDetail = model
        self.selectedIndexPath = selectedIndexPath
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
    
    func viewWillDisappear() {
        self.saveChangesToRealm()
    }
    
    func viewDidDisappear() {
        self.didTapBackBtn?()
    }
}

private extension DeliveryDetailViewModel {
    func saveChangesToRealm() {
        let localRealm = try? Realm()
        let task = localRealm?.objects(MyDeliveryModelList.self)
        try? localRealm?.write({
            task?[0].myDeliveryModelList[selectedIndexPath.row].isFavorite = deliveryDetail.isFavorite
        })
    }
    
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
