//
//  OptionalItemTableCell.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class OptionalItemTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var collectionVu: UICollectionView!
    
    var ingredientAll: [IngredientAll]?
    
    var completion : ((Bool) -> Void)?

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
        if ingredientAll != nil{
            return ingredientAll?.count ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionalItemCollectionCell", for: indexPath) as! OptionalItemCollectionCell
        cell.ingredientAll = ingredientAll?[indexPath.item]
        cell.checkBtn.setImage(UIImage(named: "uncheck-box"), for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionalItemCollectionCell
        
        guard let ingrediantId = ingredientAll?[indexPath.item].ingrediantId else {
            return
        }
        
        guard let ingrediantName = ingredientAll?[indexPath.item].ingrediantName else {
            return
        }
        
        guard let ingrediantPrice = ingredientAll?[indexPath.item].ingrediantPrice else {
            return
        }
        
        let item = ["ingrediantId": ingrediantId, "ingrediantName": ingrediantName, "ingrediantPrice": ingrediantPrice]
        
        if cell.checkBtn.imageView?.image == UIImage(named: "check-box"){
            cell.checkBtn.setImage(UIImage(named: "uncheck-box"), for: .normal)
            
            for index in 0...(ItemDetailVC.requiredArray.count - 1){
                if (ItemDetailVC.requiredArray[index]["ingrediantId"] as! String == ingrediantId){
                    ItemDetailVC.requiredArray.remove(at: index)
                    ItemDetailVC.totalPrice = ItemDetailVC.totalPrice! - Double(ingrediantPrice)!
                    break;
                }
            }
        }else{
            cell.checkBtn.setImage(UIImage(named: "check-box"), for: .normal)
            
            ItemDetailVC.requiredArray.append(item)
            
            ItemDetailVC.totalPrice = ItemDetailVC.totalPrice! + Double(ingrediantPrice)!
        }
        
        print("ItemDetailVC.requiredArray is: \(ItemDetailVC.requiredArray)")
        
        completion!(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
