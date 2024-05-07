//
//  NotificationTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/24/20.
//

import UIKit

class NotificationTableCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var notificationModel: NotificationModel?{
        didSet{
            let imageUrl = BaseUrls.baseUrlImages + (notificationModel?.senderImage)!
            self.notificationImage.downloadImage(imageUrl: imageUrl)
            titleLbl.text = notificationModel?.notificationTitle
            dateLbl.text = notificationModel?.notificationDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        notificationImage.round()
        notificationImage.layer.borderWidth = 1
        notificationImage.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
