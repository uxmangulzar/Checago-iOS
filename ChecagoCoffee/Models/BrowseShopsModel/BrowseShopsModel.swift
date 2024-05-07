//
//  BrowseShopsModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/30/20.
//

import Foundation

class BrowseShopsModel {
    
    var shopId: String?
    var shopImage: String?
    var shopName: String?
    var shopDesc: String?
    var shopAddress: String?
    var shopLat: String?
    var shopLng: String?
    var shopDistance: Double?
    var shopRating: String?
    var creationDate: String?
    
    var shopTiming = [ShopTiming]()
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        shopId = json["shop_id"] as? String
        shopImage = json["shop_image"] as? String
        shopName = json["shop_name"] as? String
        shopDesc = json["shop_description"] as? String
        shopAddress = json["shop_address"] as? String
        shopLat = json["shop_lat"] as? String
        shopLng = json["shop_lng"] as? String
        shopDistance = json["shop_distance"] as? Double
        shopRating = json["shop_total_rating"] as? String
        creationDate = json["shop_created_at"] as? String
        
        shopTiming = [ShopTiming]()
        let shopTimings = json["shop_timing"] as? [[String: Any]]
        if shopTimings != nil{
            for timing in shopTimings! {
                shopTiming.append(ShopTiming(json: timing))
            }
        }
    }
}

class ShopTiming {
    
    var opening: String!
    var closing: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        opening = json["shop_time_opening"] as? String
        closing = json["shop_time_closing"] as? String
    }
}
