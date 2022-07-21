//
//  MyDeliveryViewModel.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import CoreData

protocol MyDeliveryViewModelProtocol {
    // TableView
    var numberOfRows: Int { get }
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryModel
    func didSelectCell(at indexPath: IndexPath)
    
    // API call
    func loadData(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void)
    func fetchDeliveryList(isPagination: Bool, completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void)
}

final class MyDeliveryViewModel {
    private let service: MyDeliveryServiceProtocol
    private var deliveryList: [MyDeliveryModel?] = []
    private var currentPage: Int = 1
    private let moc = CoreDataManager.shared
    var didSelect: ((_ model: MyDeliveryModel) -> Void)?
    
    init(service: MyDeliveryServiceProtocol) {
        self.service = service
    }
}

extension MyDeliveryViewModel: MyDeliveryViewModelProtocol {
    var numberOfRows: Int {
        return self.deliveryList.count
    }
    
    func cellAt(_ indexPath: IndexPath) -> MyDeliveryModel {
        fetchListOfDeliveryFromCoreData()
        let cModel = MyDeliveryModel(id: deliveryList[indexPath.row]?.id ?? "",
                                     senderTitle: deliveryList[indexPath.row]?.senderTitle ?? "",
                                     receiverTitle: deliveryList[indexPath.row]?.receiverTitle ?? "",
                                     deliveryFee: deliveryList[indexPath.row]?.deliveryFee ?? "",
                                     surcharge: deliveryList[indexPath.row]?.surcharge ?? "",
                                     imageURLString: deliveryList[indexPath.row]?.imageURLString ?? "",
                                     isFavorite: deliveryList[indexPath.row]?.isFavorite ?? false)
        return cModel
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        self.didSelect?(cellAt(indexPath))
    }
    
    func loadData(completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        self.fetchListOfDeliveryFromCoreData()
        if self.deliveryList.isEmpty {
            fetchDeliveryList(isPagination: false, completionHandler: completionHandler)
        } else {
            completionHandler(true, nil)
        }
    }
    
    func fetchDeliveryList(isPagination: Bool, completionHandler: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        guard !service.isPaginating, self.currentPage <= 5 else { return }
        service.fetchListOfDeliveries(isPagination: isPagination) { [weak self] result in
            switch result {
            case .success(let data):
                self?.deliveryList = self?.convertDeliveryDetailsToModel(data) ?? []
                self?.currentPage += 1
                self?.moc.saveContext()
                completionHandler(true, nil)
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
}

private extension MyDeliveryViewModel {
    func convertDeliveryDetailsToModel(_ details: [DeliveryDetails]) -> [MyDeliveryModel] {
        var modelArr: [MyDeliveryModel] = []
        for detail in details {
            let model = MyDeliveryModel(id: detail.id ?? "",
                                        senderTitle: detail.route?.start ?? "",
                                        receiverTitle: detail.route?.end ?? "",
                                        deliveryFee: detail.deliveryFee ?? "",
                                        surcharge: detail.surcharge ?? "",
                                        imageURLString: detail.goodsPicture ?? "",
                                        isFavorite: false)
            modelArr.append(model)
        }
        return modelArr
    }
    
    func fetchListOfDeliveryFromCoreData() {
        let data = DeliveryList(context: moc.managedObjectContext())
        self.deliveryList.append(data.convertToMyDeliveryModel())
    }
}
