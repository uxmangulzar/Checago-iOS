//
//  CoffeeShopDetailTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class CoffeeShopDetailTableCell: UITableViewCell {

    @IBOutlet weak var coffeeShopImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var openCloseLbl: UILabel!
    @IBOutlet weak var timingLbl: UILabel!
    
    var shopModel: BrowseShopsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (shopModel?.shopImage)!
            self.coffeeShopImage.downloadImage(imageUrl: imageUrl)
            nameLbl.text = shopModel?.shopAddress
            timingLbl.text = (shopModel?.shopTiming[0].opening)! + " - " + (shopModel?.shopTiming[0].closing)!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coffeeShopImage.roundCorners([.topLeft, .topRight], radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
