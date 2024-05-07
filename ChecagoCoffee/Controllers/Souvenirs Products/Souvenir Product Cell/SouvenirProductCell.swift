//
//  SouvenirProductCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class SouvenirProductCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var triangleImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var productModel: ProductsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (productModel?.productImage)!
            self.itemImage.downloadImage(imageUrl: imageUrl)
            title.text = (productModel?.productName)!
            titleLbl.text = (productModel?.productWeight)! + " oz \n $" + (productModel?.productPrice)! + "\n" + (String((productModel?.productSizes.count)!)) + " Sizes Available"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImage.roundCorners([.topLeft, .topRight], radius: 10)
        triangleImage.roundCorners([.topLeft], radius: 10)
    }
}
