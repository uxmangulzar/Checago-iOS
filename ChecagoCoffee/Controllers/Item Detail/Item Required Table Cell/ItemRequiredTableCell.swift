//
//  ItemRequiredTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class ItemRequiredTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionVu: UICollectionView!
    
    var productSizes: [ProductSizes]?{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.collectionVu.reloadData()
            }
        }
    }
    
    var completion : (([String: Any]) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionVu.showsHorizontalScrollIndicator = false
        
        collectionVu.delegate = self
        collectionVu.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if productSizes != nil{
            return productSizes!.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemRequiredCollectionCell", for: indexPath) as! ItemRequiredCollectionCell
        
        cell.productSize = productSizes?[indexPath.row]
        
        if productSizes?[indexPath.row].isSelected == false{
            cell.circleBtn.setImage(UIImage(named: "empty-icon"), for: .normal)
        }else{
            cell.circleBtn.setImage(UIImage(named: "selected-icon"), for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemRequiredCollectionCell
        cell.circleBtn.setImage(UIImage(named: "selected-icon"), for: .normal)
        productSizes?[indexPath.row].isSelected = true
        
        if indexPath.row != 0{
            let indexPath = IndexPath(row: 0, section: 0)
            let firstCell = collectionVu.cellForItem(at: indexPath) as? ItemRequiredCollectionCell
            firstCell?.circleBtn.setImage(UIImage(named: "empty-icon"), for: .normal)
            productSizes?[0].isSelected = false
        }
        
        guard let productPrice = productSizes![indexPath.item].productPrice else {
            return
        }
        
        guard let productSizeId = productSizes![indexPath.item].productSizeId else {
            return
        }
        
        guard let productSizeName = productSizes![indexPath.item].productSizeName else {
            return
        }
        
        completion!(["productPrice": productPrice, "productSizeId": productSizeId, "productSizeName": productSizeName])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemRequiredCollectionCell
        cell.circleBtn.setImage(UIImage(named: "empty-icon"), for: .normal)
        productSizes?[indexPath.row].isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
