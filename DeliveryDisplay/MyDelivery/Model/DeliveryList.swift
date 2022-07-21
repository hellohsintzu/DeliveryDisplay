//
//  DeliveryList.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/19.
//

import CoreData

@objc
class DeliveryList: NSManagedObject {
    @NSManaged var deliveryFee: String?
    @NSManaged var end: String?
    @NSManaged var goodsPicture: String?
    @NSManaged var id: String?
    @NSManaged var isFavorite: Bool
    @NSManaged var start: String?
    @NSManaged var surcharge: String?
    
    func convertToMyDeliveryModel() -> MyDeliveryModel? {
        guard let id = self.id,
              let senderTitle = self.start,
              let receiverTitle = self.end,
              let deliveryFee = self.deliveryFee,
              let surcharge = self.surcharge,
              let imageURLString = self.goodsPicture else {
                  return nil
              }
                
        let model = MyDeliveryModel(id: id,
                                    senderTitle: senderTitle,
                                    receiverTitle: receiverTitle,
                                    deliveryFee: deliveryFee,
                                    surcharge: surcharge,
                                    imageURLString: imageURLString,
                                    isFavorite: isFavorite)
        return model
    }
}
