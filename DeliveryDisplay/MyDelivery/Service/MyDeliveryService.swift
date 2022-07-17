//
//  MyDeliveryService.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

protocol MyDeliveryServiceProtocol {
    func fetchListOfDeliveries(completionHandler: @escaping (Result<[DeliveryDetails], ErrorModel>) -> Void)
}

final class MyDeliveryService {
    private let networkClient: NetworkServiceProtocol
    
    init(networkClient: NetworkServiceProtocol) {
        self.networkClient = networkClient
    }
}

extension MyDeliveryService: MyDeliveryServiceProtocol {
    func fetchListOfDeliveries(completionHandler: @escaping (Result<[DeliveryDetails], ErrorModel>) -> Void) {
        let urlString = "\(Constants.APIConstants.urlString)\(Constants.APIConstants.endpoint)"
        
        networkClient.request(urlString: urlString, model: [DeliveryDetails].self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
