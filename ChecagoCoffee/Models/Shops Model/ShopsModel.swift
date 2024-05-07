//
//  ShopsModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/29/20.
//

import Foundation

class ShopsModel {
    
    var shopId: String!
    var shopImage: String!
    var shopName: String!
    var shopDesc: String!
    var shopLat: String!
    var shopLng: String!
    var creationDate: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        shopId = json["shop_id"] as? String
        shopImage = json["shop_image"] as? String
        shopName = json["shop_name"] as? String
        shopDesc = json["shop_description"] as? String
        shopLat = json["shop_lat"] as? String
        shopLng = json["shop_lng"] as? String
        creationDate = json["shop_created_at"] as? String
    }
}
