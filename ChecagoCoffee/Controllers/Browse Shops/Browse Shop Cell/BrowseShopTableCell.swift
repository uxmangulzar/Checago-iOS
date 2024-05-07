//
//  BrowseShopTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class BrowseShopTableCell: UITableViewCell {

    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var shopDescLbl: UILabel!
    @IBOutlet weak var shopAddresslbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    var shopModel: BrowseShopsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (shopModel?.shopImage)!
            self.shopImage.downloadImage(imageUrl: imageUrl)
            shopNameLbl.text = shopModel?.shopName
            shopDescLbl.text = shopModel?.shopDesc
            shopAddresslbl.text = shopModel?.shopAddress
            distanceLbl.text = String(shopModel?.shopDistance ?? 0.00) + " miles"
            ratingLbl.text = shopModel?.shopRating
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shopImage.roundCorners([.topLeft, .topRight], radius: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
