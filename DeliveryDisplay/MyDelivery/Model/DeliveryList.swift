//
//  DeliveryList.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/19.
//

import RealmSwift

class MyDeliveryModelList: Object {
    @Persisted var myDeliveryModelList: List<DeliveryList>
    
    convenience init(myDeliveryModelList: List<DeliveryList>) {
        self.init()
        self.myDeliveryModelList = myDeliveryModelList
    }
}

class DeliveryList: Object {
    @Persisted var deliveryFee: String?
    @Persisted var end: String?
    @Persisted var goodsPicture: String?
    @Persisted var id: String?
    @Persisted var isFavorite: Bool
    @Persisted var start: String?
    @Persisted var surcharge: String?
    
    convenience init(id: String, start: String, end: String, deliveryFee: String, surcharge: String, goodsPicture: String, isFavorite: Bool) {
        self.init()
        self.id = id
        self.start = start
        self.end = end
        self.deliveryFee = deliveryFee
        self.surcharge = surcharge
        self.goodsPicture = goodsPicture
        self.isFavorite = isFavorite
    }
    
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
