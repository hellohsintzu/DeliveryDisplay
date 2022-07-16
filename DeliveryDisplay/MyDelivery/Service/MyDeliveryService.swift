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
        let urlString = "https://\(Constants.APIConstants.urlString)\(Constants.APIConstants.endpoint)"
        let params: [String: Any] = [Constants.APIConstants.offset: 0,
                                     Constants.APIConstants.limit: 10]
        
        networkClient.request(urlString: urlString, requestParams: params, model: [DeliveryDetails].self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
