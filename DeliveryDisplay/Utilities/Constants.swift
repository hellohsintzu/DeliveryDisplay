//
//  Constants.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

struct Constants {
    struct APIConstants {
        static let urlString = "https://6285f87796bccbf32d6c0e6a.mockapi.io"
        static let endpoint = "/deliveries"
        static let offset = "offset"
        static let limit = "limit"
    }
    
    struct MyDelivery {
        static let myDeliveryTitle =  "My Deliveries"
        static let alertBtnTitle = "Got it"
        static let alertTitle = "Oops...something went wrong"
        static let senderLabel = "From: "
        static let receiverLabel = "To: "
        static let feeLabel = "$"
    }
    
    struct DeliveryDetail {
        static let deliveryDetailsTitle = "Delivery Details"
        static let favBtnTitle = "Add to Favorite"
        static let goodsTitle = "Goods to deliver"
        static let feeTitle = "Delivery Fee"
    }
}
