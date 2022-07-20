//
//  MyDeliveryModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation

struct MyDeliveryModel {
    var id: String
    var senderTitle: String
    var receiverTitle: String
    var deliveryFee: String
    var surcharge: String
    var imageURLString: String
    var isFavorite: Bool
    
    init(id: String, senderTitle: String, receiverTitle: String, deliveryFee: String, surcharge: String, imageURLString: String, isFavorite: Bool) {
        self.id = id
        self.senderTitle = senderTitle
        self.receiverTitle = receiverTitle
        self.deliveryFee = deliveryFee
        self.surcharge = surcharge
        self.imageURLString = imageURLString
        self.isFavorite = isFavorite
    }
}
