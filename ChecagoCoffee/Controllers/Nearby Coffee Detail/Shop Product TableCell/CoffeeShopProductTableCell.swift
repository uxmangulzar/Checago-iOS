//
//  CoffeeShopProductTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class CoffeeShopProductTableCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var triangleImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var productModel: ProductsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (productModel?.productImage)!
            self.productImage.downloadImage(imageUrl: imageUrl)
            nameLbl.text = productModel?.productName
            sizeLbl.text = String(productModel?.productSizes.count ?? 0) + " Sizes Available"
            priceLbl.text = "$" + (productModel?.productPrice)!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productImage.roundCorners([.topLeft, .bottomLeft], radius: 8)
        triangleImage.roundCorners([.topLeft], radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
