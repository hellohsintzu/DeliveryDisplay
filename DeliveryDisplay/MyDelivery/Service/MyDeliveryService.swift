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
    private let moc = CoreDataManager.shared.moc
    private var isPaginationOn: Bool = false
    private var deliveryList: [DeliveryDetails] = []
    
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
        if deliveryList.isEmpty {
            let urlString = "\(Constants.APIConstants.urlString)\(Constants.APIConstants.endpoint)"
            
            networkClient.request(urlString: urlString, model: [DeliveryDetails].self) { result in
                switch result {
                case .success(let data):
                    do {
                        try self.moc.save()
                    } catch {
                        debugPrint(error)
                    }
                    completionHandler(.success(data))
                    if isPagination {
                        self.isPaginating = false
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } else {
            completionHandler(.success(deliveryList))
        }
    }
    
    private func fetchListOfDeliveryFromCoreData() {
        let request = NSFetchRequest<DeliveryDetails>(entityName: "Delivery")
        do {
            let data = try moc.fetch(request)
            self.deliveryList = data
        } catch {
            print(error.localizedDescription)
            self.deliveryList = []
        }
    }
}
