//
//  OptionalItemCollectionCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class OptionalItemCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    var ingredientAll: IngredientAll?{
        didSet{
            nameLbl.text = (ingredientAll?.ingrediantName)! + "($" + (ingredientAll?.ingrediantPrice)! + ")"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkBtn.tintColor = UIColor.systemYellow
    }
}
