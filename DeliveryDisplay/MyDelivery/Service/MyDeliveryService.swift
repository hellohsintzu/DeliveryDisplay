//
//  MyDeliveryService.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation
import CoreData

protocol MyDeliveryServiceProtocol {
    var isPaginating: Bool { get set }
    func fetchListOfDeliveries(isPagination: Bool, completionHandler: @escaping (Result<[DeliveryDetails], ErrorModel>) -> Void)
}

final class MyDeliveryService {
    private let networkClient: NetworkServiceProtocol
    private var isPaginationOn: Bool = false
    private var deliveryList: [MyDeliveryModel] = []
    
    init(networkClient: NetworkServiceProtocol) {
        self.networkClient = networkClient
    }
}

extension MyDeliveryService: MyDeliveryServiceProtocol {
    var isPaginating: Bool {
        get {
            return isPaginationOn
        }
        
        set {
            isPaginationOn = newValue
        }
    }
    
    func fetchListOfDeliveries(isPagination: Bool, completionHandler: @escaping (Result<[DeliveryDetails], ErrorModel>) -> Void) {
        if isPagination {
            self.isPaginating = true
        }
        let urlString = "\(Constants.APIConstants.urlString)\(Constants.APIConstants.endpoint)"
        networkClient.request(urlString: urlString, model: [DeliveryDetails].self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
                if isPagination {
                    self.isPaginating = false
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
