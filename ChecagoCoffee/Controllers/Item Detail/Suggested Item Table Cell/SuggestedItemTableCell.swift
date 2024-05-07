//
//  SuggestedItemTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class SuggestedItemTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionVu: UICollectionView!
    
    @IBOutlet weak var estimatedTime: UILabel!
    
    var suggestedProducts: [ProductsModel]?{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.collectionVu.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionVu.delegate = self
        collectionVu.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if suggestedProducts != nil{
            return suggestedProducts!.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedItemsCell", for: indexPath) as! SuggestedItemsCell
        cell.suggestedProduct = suggestedProducts?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
