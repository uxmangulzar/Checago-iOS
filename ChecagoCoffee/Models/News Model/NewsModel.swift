//
//  NewsModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/29/20.
//

import Foundation

class NewsModel {
    
    var newsId: String!
    var newsName: String!
    var newsLink: String!
    var newsImage: String!
    var newsStatus: String!
    var creationDate: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        newsId = json["news_id"] as? String
        newsName = json["news_name"] as? String
        newsLink = json["news_link"] as? String
        newsImage = json["news_image"] as? String
        newsStatus = json["news_status"] as? String
        creationDate = json["news_created_at"] as? String
    }
}
