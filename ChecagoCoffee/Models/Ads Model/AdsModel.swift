//
//  AdsModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/29/20.
//

import Foundation

class AdsModel {
    
    var adId: String!
    var adImage: String!
    var adLink: String!
    var adName: String!
    var adStatus: String!
    var creationDate: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        adId = json["ad_id"] as? String
        adImage = json["ad_image"] as? String
        adLink = json["ad_link"] as? String
        adName = json["ad_name"] as? String
        adStatus = json["ad_status"] as? String
        creationDate = json["ad_created_at"] as? String
    }
}
