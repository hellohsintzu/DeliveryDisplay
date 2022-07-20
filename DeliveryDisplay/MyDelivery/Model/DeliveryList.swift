//
//  DeliveryList.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/19.
//

import CoreData

class DeliveryList: NSManagedObject {
    @NSManaged var deliveryFee: String?
    @NSManaged var end: String?
    @NSManaged var goodsPicture: String?
    @NSManaged var id: String?
    @NSManaged var isFavorite: Bool
    @NSManaged var start: String?
    @NSManaged var surcharge: String?
    
    func convertToMyDeliveryModel() -> MyDeliveryModel {
        let model = MyDeliveryModel(id: self.id ?? "",
                                    senderTitle: self.start ?? "",
                                    receiverTitle: self.end ?? "",
                                    deliveryFee: self.deliveryFee ?? "",
                                    surcharge: self.surcharge ?? "",
                                    imageURLString: self.goodsPicture ?? "",
                                    isFavorite: self.isFavorite)
        return model
    }
}
