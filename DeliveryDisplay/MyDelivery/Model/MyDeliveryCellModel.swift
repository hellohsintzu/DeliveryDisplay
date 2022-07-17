//
//  MyDeliveryCellModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import Foundation

struct MyDeliveryCellModel {
    var senderTitle: String
    var receiverTitle: String
    var feeTitle: String
    var imageURLString: String
    var isFavorite: Bool
    
    init(senderTitle: String, receiverTitle: String, feeTitle: String, imageURLString: String, isFavorite: Bool) {
        self.senderTitle = senderTitle
        self.receiverTitle = receiverTitle
        self.feeTitle = feeTitle
        self.imageURLString = imageURLString
        self.isFavorite = isFavorite
    }
}
