//
//  SuggestedItemsCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class SuggestedItemsCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var triangleImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var suggestedProduct: ProductsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (suggestedProduct?.productImage)!
            self.itemImage.downloadImage(imageUrl: imageUrl)
            nameLbl.text = suggestedProduct?.productName
            priceLbl.text = "$" + (suggestedProduct?.productPrice)! + " for " + (suggestedProduct?.productSizes[0].productSizeName)!
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImage.roundCorners([.topLeft, .topRight], radius: 10)
        triangleImage.roundCorners([.topLeft], radius: 10)
    }
}
