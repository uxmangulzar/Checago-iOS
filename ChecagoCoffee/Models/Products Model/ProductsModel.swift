//
//  ProductsModel.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/29/20.
//

import Foundation

class ProductsModel {
    
    var productId: Int?
    var productIdString: String?
    var shopId: String?
    var productName: String?
    var productDesc: String?
    var productWeight: String?
    var productQuantity: String?
    var productImage: String?
    var productPrice: String?
    var productStatus: String?
    var creationDate: String?
    
    var productIngradients = [ProductIngredients]()
    var productSizes = [ProductSizes]()
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        productId = json["product_id"] as? Int
        productIdString = json["product_id"] as? String
        shopId = json["product_shop_id"] as? String
        productName = json["product_name"] as? String
        productDesc = json["product_description"] as? String
        productWeight = json["product_weight"] as? String
        productQuantity = json["product_quantity"] as? String
        productImage = json["product_image"] as? String
        productPrice = json["product_price"] as? String
        productStatus = json["product_status"] as? String
        creationDate = json["shop_created_at"] as? String
        
        productIngradients = [ProductIngredients]()
        let productIngredients = json["product_ingredients"] as? [[String: Any]]
        if productIngredients != nil{
            for ingredients in productIngredients! {
                productIngradients.append(ProductIngredients(json: ingredients))
            }
        }
        
        productSizes = [ProductSizes]()
        let product_Sizes = json["product_sizes"] as? [[String: Any]]
        if product_Sizes != nil{
            for sizes in product_Sizes! {
                productSizes.append(ProductSizes(json: sizes))
            }
        }
    }
}

class ProductSizes {
    
    var productPrice: String?
    var productSizeId: String?
    var productSizeName: String?
    
    var isSelected = false
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        productPrice = json["product_price"] as? String
        productSizeId = json["product_size_id"] as? String
        productSizeName = json["product_size_name"] as? String
    }
}

class ProductIngredients {
    
    var ingredientTypeName: String?
    var ingredientAll = [IngredientAll]()
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        ingredientTypeName = json["ingredient_type_name"] as? String
        ingredientAll = [IngredientAll]()
        let allIngredients = json["ingredient_all"] as? [[String: Any]]
        if allIngredients != nil{
            for ingredient in allIngredients! {
                ingredientAll.append(IngredientAll(json: ingredient))
            }
        }
    }
}

class IngredientAll {
    
    var ingrediantId: String?
    var ingrediantName: String?
    var ingrediantPrice: String?
    
    init(json: [String: Any]) {
        if json.isEmpty{
            return
        }
        
        ingrediantId = json["ingredient_id"] as? String
        ingrediantName = json["ingredient_name"] as? String
        ingrediantPrice = json["ingredient_price"] as? String
    }
}
