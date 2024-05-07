//
//  NotificationModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/30/20.
//

import Foundation

class NotificationModel {
    
    var notificationId: Int!
    var notificationTitle: String!
    var senderImage: String!
    var notificationDate: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        notificationId = json["notification_id"] as? Int
        notificationTitle = json["notification_title"] as? String
        senderImage = json["notification_sender_image"] as? String
        notificationDate = json["notification_created_at"] as? String
    }
}
