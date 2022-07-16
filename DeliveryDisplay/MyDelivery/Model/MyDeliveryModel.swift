//
//  MyDeliveryModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

struct DeliveryDetails: Codable {
    var id: String?
    var remarks: String?
    var pickupTime: String?
    var goodsPicture: String?
    var deliveryFee: String?
    var surcharge: String?
    var route: Route?
    var sender: Sender?
}

struct Route: Codable {
    var start: String?
    var end: String?
}

struct Sender: Codable {
    var phone: String?
    var name: String?
    var email: String?
}
