//
//  MyDeliveryService.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

protocol MyDeliveryServiceProtocol {
    func fetchListOfDeliveries(urlString: String, completionHandler: @escaping (Result<DeliveryDetails, ErrorModel>) -> Void)
}

final class MyDeliveryService: MyDeliveryServiceProtocol {
    func fetchListOfDeliveries(urlString: String, completionHandler: @escaping (Result<DeliveryDetails, ErrorModel>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
    }
}
