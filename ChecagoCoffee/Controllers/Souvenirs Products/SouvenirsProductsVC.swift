//
//  SouvenirsProductsVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/28/20.
//

import UIKit

class SouvenirsProductsVC: UIViewController, serverResponse {
    
    @IBOutlet weak var collectionVu: UICollectionView!
    
    let verticalCollectionWidth = UIScreen.main.bounds.width - 40
    
    var productModel = [ProductsModel]()
    
    var subCatId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionVu.reloadData()
        }
    }
    
    func getData(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_ALL_PRODUCTS_BY_SUBID.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = ["user_id":userId,
                                          "sub_cat_id":subCatId!,
                                          "u_type":"user",
                                          "limit":"100",
                                          "page":"1"]
            
            print("params are: \(params)")
            
            serverRequest.delegate = self
            serverRequest.postRequestWithRawData(url: url, header: headers, params: params, type: "")
        }else{
            Alert.showInternetFailureAlert(on: self)
        }
    }
    
    func onResponse(json: [String : Any], val: String) {
        let error = json["error"] as? Bool
        if error == false{
            productModel.removeAll()
            let allProducts = json["all_products"] as! [[String: Any]]
            for singleProduct in allProducts {
                productModel.append(ProductsModel(json: singleProduct))
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionVu.reloadData()
            }
        }
        Utils.sharedInstance.stopIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SouvenirsProductsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SouvenirProductCell", for: indexPath) as! SouvenirProductCell
        cell.productModel = productModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = verticalCollectionWidth/2 - 5
        return CGSize(width: cellWidth, height: cellWidth * 1.34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
