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
    
    init(senderTitle: String, receiverTitle: String, feeTitle: String, imageURLString: String) {
        self.senderTitle = senderTitle
        self.receiverTitle = receiverTitle
        self.feeTitle = feeTitle
        self.imageURLString = imageURLString
    }
}
