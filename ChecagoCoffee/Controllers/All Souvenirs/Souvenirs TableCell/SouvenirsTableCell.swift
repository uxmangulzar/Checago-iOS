//
//  SouvenirsTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class SouvenirsTableCell: UITableViewCell {

    @IBOutlet weak var souvenirImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleBackVu: UIView!
    
    var subCatModel: SubCategoryModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (subCatModel?.subCatImage)!
            self.souvenirImage.downloadImage(imageUrl: imageUrl)
            titleLbl.text = subCatModel?.subCatName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleBackVu.roundCorners([.bottomLeft, .bottomRight], radius: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
