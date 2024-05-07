//
//  ItemDetailCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class ItemDetailCell: UITableViewCell{

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    
    var count = 1
    
    var productModel: ProductsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (productModel?.productImage)!
            self.itemImage.downloadImage(imageUrl: imageUrl)
            itemNameLbl.text = productModel?.productName
            itemPriceLbl.text = "$" + String(ItemDetailVC.totalPrice ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImage.roundCorners([.topLeft, .bottomLeft], radius: 8.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
