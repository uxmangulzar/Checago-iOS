//
//  CommunityNewsCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class CommunityNewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var newsModel: NewsModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (newsModel?.newsImage)!
            self.newsImage.downloadImage(imageUrl: imageUrl)
            titleLbl.text = newsModel?.newsName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
