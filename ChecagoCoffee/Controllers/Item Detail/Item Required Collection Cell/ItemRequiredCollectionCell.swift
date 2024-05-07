//
//  ItemRequiredCollectionCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class ItemRequiredCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var circleBtn: UIButton!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    var productSize: ProductSizes?{
        didSet{
            priceLbl.text = "$" + (productSize?.productPrice)!
        }
    }
    
}
