//
//  Constants.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

struct Constants {
    struct APIConstants {
        static let urlString = "6285f87796bccbf32d6c0e6a.mockapi.io"
        static let endpoint = "/deliveries"
        static let offset = "offset"
        static let limit = "limit"
    }
    
    struct MyDelivery {
        static let myDeliveryTitle =  "My Deliveries"
        static let alertBtnTitle = "Got it"
        static let alertTitle = "Oops...something went wrong"
    }
    
    struct DeliveryDetail {
        static let deliveryDetailsTitle = "Delivery Details"
    }
}
