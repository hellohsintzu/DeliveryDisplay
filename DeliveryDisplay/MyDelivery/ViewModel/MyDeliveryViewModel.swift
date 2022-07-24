//
//  MyDeliveryViewModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation
import RealmSwift

protocol MyDeliveryViewModelProtocol {
    // TableView
    var numberOfRows: Int { get }
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryModel
    func didSelectCell(at indexPath: IndexPath)
    
    // API call
    func loadData(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void)
    func prepareNextPage(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void)
}

final class MyDeliveryViewModel {
    private let service: MyDeliveryServiceProtocol
    private var displayDeliveryList: [MyDeliveryModel?] = []
    private var selectedIndexPath: IndexPath?
    private var currentPage: Int = 1
    private var maximumItems: Int = 5
    private var maximumPages: Int = 5
    var didSelect: ((_ model: MyDeliveryModel, _ selectedIndexPath: IndexPath) -> Void)?
    
    init(service: MyDeliveryServiceProtocol) {
        self.service = service
    }
}

extension MyDeliveryViewModel: MyDeliveryViewModelProtocol {
    var numberOfRows: Int {
        return self.displayDeliveryList.count
    }
    
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryModel {
        let cModel = MyDeliveryModel(id: displayDeliveryList[indexPath.row]?.id ?? "",
                                     senderTitle: displayDeliveryList[indexPath.row]?.senderTitle ?? "",
                                     receiverTitle: displayDeliveryList[indexPath.row]?.receiverTitle ?? "",
                                     deliveryFee: displayDeliveryList[indexPath.row]?.deliveryFee ?? "",
                                     surcharge: displayDeliveryList[indexPath.row]?.surcharge ?? "",
                                     imageURLString: displayDeliveryList[indexPath.row]?.imageURLString ?? "",
                                     isFavorite: displayDeliveryList[indexPath.row]?.isFavorite ?? false)
        return cModel
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.didSelect?(cellAt(indexPath), indexPath)
    }
    
    func loadData(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        if self.displayDeliveryList.isEmpty {
            self.fetchObjectFromRealm()
        } else {
            self.updateDeliveryList()
            completionHandler(true, nil)
        }
        self.displayDeliveryList.isEmpty ? self.fetchDeliveryList(completionHandler: completionHandler) : completionHandler(true, nil)
    }
    
    func prepareNextPage(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        guard self.currentPage < maximumPages else { return }
        self.currentPage += 1
        if displayDeliveryList.count < currentPage*maximumItems {
            self.fetchDeliveryList(completionHandler: completionHandler)
        }
    }
}

private extension MyDeliveryViewModel {
    func fetchDeliveryList(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        service.fetchListOfDeliveries { [weak self] result in
            switch result {
            case .success(let data):
                self?.saveDeliveryDetailsToVM(data)
                self?.saveResponseToRealm(data)
                completionHandler(true, nil)
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
    
    func saveDeliveryDetailsToVM(_ details: [DeliveryDetails]) {
        for detail in details {
            let model = MyDeliveryModel(id: detail.id ?? "",
                                        senderTitle: detail.route?.start ?? "",
                                        receiverTitle: detail.route?.end ?? "",
                                        deliveryFee: detail.deliveryFee ?? "",
                                        surcharge: detail.surcharge ?? "",
                                        imageURLString: detail.goodsPicture ?? "",
                                        isFavorite: false)
            self.displayDeliveryList.append(model)
        }
    }
    
    func fetchObjectFromRealm() {
        let localRealm: Realm? = try? Realm()
        let realmObject = localRealm?.objects(MyDeliveryModelList.self)
        if let object = realmObject?.first {
            for model in object.myDeliveryModelList {
                self.displayDeliveryList.append(model.convertToMyDeliveryModel())
            }
        }
    }
    
    func updateDeliveryList() {
        print("self.displayDeliveryList\(self.displayDeliveryList)")
        guard let indexPath = self.selectedIndexPath else { return }
        let localRealm = try? Realm()
        let task = localRealm?.objects(MyDeliveryModelList.self)
        if let taskWithID = task?.where({
            $0.myDeliveryModelList.id == self.displayDeliveryList[indexPath.row]?.id
        }) {
            self.displayDeliveryList[indexPath.row] = taskWithID[0].myDeliveryModelList[currentPage-1].convertToMyDeliveryModel()
        }
    }
    
    func saveResponseToRealm(_ data: [DeliveryDetails]) {
        let localRealm: Realm? = try? Realm()
        let realmObject = localRealm?.objects(MyDeliveryModelList.self)
        if let object = realmObject?.first {
            try? localRealm?.write({
                let list = object.myDeliveryModelList
                for detail in data {
                    let model = DeliveryList(id: detail.id ?? "",
                                             start: detail.route?.start ?? "",
                                             end: detail.route?.end ?? "",
                                             deliveryFee: detail.deliveryFee ?? "",
                                             surcharge: detail.surcharge ?? "",
                                             goodsPicture: detail.goodsPicture ?? "",
                                             isFavorite: false)
                    list.append(model)
                }
                object.myDeliveryModelList = list
                print(" object.myDeliveryModelList \(object.myDeliveryModelList)")
            })
        } else {
            let object = List<DeliveryList>()
            for detail in data {
                let model = DeliveryList(id: detail.id ?? "",
                                         start: detail.route?.start ?? "",
                                         end: detail.route?.end ?? "",
                                         deliveryFee: detail.deliveryFee ?? "",
                                         surcharge: detail.surcharge ?? "",
                                         goodsPicture: detail.goodsPicture ?? "",
                                         isFavorite: false)
                object.append(model)
            }
            let deliveryModel = MyDeliveryModelList(myDeliveryModelList: object)
            try? localRealm?.write({
                localRealm?.add(deliveryModel)
            })
            print("deliveryModel \(deliveryModel)")
        }
    }
}
