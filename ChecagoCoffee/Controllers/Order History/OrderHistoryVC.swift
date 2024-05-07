//
//  OrderHistoryVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/24/20.
//

import UIKit

struct Category {
    var title:String!
    var isSelected = false
}

class OrderHistoryVC: UIViewController {
    
    @IBOutlet weak var collectionVu: UICollectionView!
    
    private var catArray = [Category(title: "Food/Baverages", isSelected: true),
                            Category(title: "Souvenirs", isSelected: false)]
    
    let verticalCollectionWidth = UIScreen.main.bounds.width - 40

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionVu.layer.borderWidth = 0.5
        collectionVu.layer.borderColor = UIColor.placeholderText.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionVu.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        super.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OrderHistoryVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableCell", for: indexPath) as? OrderHistoryTableCell
        return cell ?? UITableViewCell()
    }
}

extension OrderHistoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.titleLbl.text = catArray[indexPath.item].title
        
        if catArray[indexPath.item].isSelected == true{
            cell.backVu.backgroundColor = UIColor.systemYellow
            cell.titleLbl.textColor = UIColor.white
        }else{
            cell.backVu.backgroundColor = UIColor.white
            cell.titleLbl.textColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        cell?.backVu.backgroundColor = UIColor.systemYellow
        cell?.titleLbl.textColor = UIColor.white
        
        catArray[indexPath.item].isSelected = !catArray[indexPath.item].isSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        cell?.backVu.backgroundColor = UIColor.white
        cell?.titleLbl.textColor = UIColor.black
        
        catArray[indexPath.item].isSelected = !catArray[indexPath.item].isSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = verticalCollectionWidth/2 - 0
        return CGSize(width: cellWidth, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
