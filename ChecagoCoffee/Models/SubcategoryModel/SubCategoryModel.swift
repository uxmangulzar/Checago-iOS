//
//  SubCategoryModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/30/20.
//

import Foundation

class SubCategoryModel {
    
    var categoryId: String!
    var subCatId: String!
    var subCatName: String!
    var subCatImage: String!
    var subCatDesc: String!
    var subCatStatus: String!
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        categoryId = json["category_id"] as? String
        subCatId = json["subcategory_id"] as? String
        subCatName = json["subcategory_name"] as? String
        subCatImage = json["subcategory_image"] as? String
        subCatDesc = json["subcategory_description"] as? String
        subCatStatus = json["subcategory_status"] as? String
    }
}
