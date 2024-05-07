//
//  NearByCoffeeDetailVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class NearByCoffeeDetailVC: UIViewController, serverResponse {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var tableVu: UITableView!
    
    var browseShopModel = [BrowseShopsModel]()
    
    var productsModel = [ProductsModel]()
    
    var shopIsOpen = false
    
    var shopId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShopInfo()
        getProducts()
    }
    
    func getShopInfo(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let currentDateDesc = Date().description(with: .current)
            let dateArr = currentDateDesc.components(separatedBy: ",")
            let weekDay = dateArr[0]
            
            let url = BaseUrls.baseUrl + "GET_SHOP_BY_SHOPID.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = [ "user_id":userId,
                                           "shop_id":self.shopId!,
                                           "shop_day":weekDay,
                                           "limit":"100",
                                           "page":"1"]
            
            print("params are: \(params)")
            
            serverRequest.delegate = self
            serverRequest.postRequestWithRawData(url: url, header: headers, params: params, type: "")
        }else{
            Alert.showInternetFailureAlert(on: self)
        }
    }
    
    func getProducts(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_SHOP_PRODUCTS.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = [ "user_id":userId,
                                           "u_type":"user",
                                           "shop_id":self.shopId!,
                                           "sub_cat_id":"1",
                                           "limit":"100",
                                           "page":"1"]
            
            print("params are: \(params)")
            
            serverRequest.delegate = self
            serverRequest.postRequestWithRawData(url: url, header: headers, params: params, type: "get_products")
        }else{
            Alert.showInternetFailureAlert(on: self)
        }
    }
    
    func onResponse(json: [String : Any], val: String) {
        if val == ""{
            print(json)
            let error = json["error"] as? Bool
            if error == false{
                let shopDetails = json["shop_details"] as! [[String: Any]]
                for shopDetail in shopDetails {
                    browseShopModel.append(BrowseShopsModel(json: shopDetail))
                }
                
                let openingTime = browseShopModel[0].shopTiming[0].opening
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                let openingDate = dateFormatter.date(from: openingTime!)
                dateFormatter.dateFormat = "HH:mm"
                let shopOpeningTime = dateFormatter.string(from: openingDate!)
                
                let openingTimeArr = shopOpeningTime.components(separatedBy: ":")
                let openFirstValue = Int(openingTimeArr[0])
                let openLastValue = Int(openingTimeArr[1])
                
                print(openFirstValue)
                print(openLastValue)
                
                let closingTime = browseShopModel[0].shopTiming[0].closing
                dateFormatter.dateFormat = "hh:mm a"
                let closingDate = dateFormatter.date(from: closingTime!)
                dateFormatter.dateFormat = "HH:mm"
                let shopClosingTime = dateFormatter.string(from: closingDate!)
                
                let closeTimeArr = shopClosingTime.components(separatedBy: ":")
                let closeFirstValue = Int(closeTimeArr[0])
                let closeLastValue = Int(closeTimeArr[1])
                
                print(closeFirstValue)
                print(closeLastValue)
                
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let currentTime = formatter.string(from: currentDate)
                
                let currentTimeArr = currentTime.components(separatedBy: ":")
                let currentTimeFirstValue = Int(currentTimeArr[0])
                let currentTimeLastValue = Int(currentTimeArr[1])
                
                print(currentTimeFirstValue)
                print(currentTimeLastValue)
                
                if (currentTimeFirstValue! > openFirstValue! || (currentTimeFirstValue == openFirstValue && currentTimeLastValue! >= openLastValue!)) && (currentTimeFirstValue! < closeFirstValue! || (currentTimeFirstValue == closeFirstValue && currentTimeLastValue! >= closeLastValue!)){
                    shopIsOpen = true
                    print("Shop is open")
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.titleLbl.text = self?.browseShopModel[0].shopName
                    self?.tableVu.reloadData()
                }
            }
        }else if val == "get_products"{
            print(json)
            let error = json["error"] as? Bool
            if error == false{
                let allProducts = json["all_products"] as! [[String: Any]]
                for singleProduct in allProducts {
                    productsModel.append(ProductsModel(json: singleProduct))
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableVu.reloadData()
                }
            }
        }
        Utils.sharedInstance.stopIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            self?.tableVu.reloadData()
        }
    }
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NearByCoffeeDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if browseShopModel.count > 0 && productsModel.count == 0{
            return 1
        }else if browseShopModel.count > 0 && productsModel.count > 0{
            return 1 + productsModel.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeShopDetailTableCell", for: indexPath) as? CoffeeShopDetailTableCell
            cell?.shopModel = browseShopModel[indexPath.row]
            if shopIsOpen == true{
                cell?.openCloseLbl.text = "Open Now"
            }else{
                cell?.openCloseLbl.text = "Shop is closed"
            }
            
            return cell ?? UITableViewCell()
        }else{
            let newIndex = indexPath.row - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeShopProductTableCell", for: indexPath) as? CoffeeShopProductTableCell
            cell?.productModel = productsModel[newIndex]
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            if shopIsOpen == true{
                let newIndex = indexPath.row - 1
                let vc: ItemDetailVC = UIStoryboard.controller()
                vc.productId = productsModel[newIndex].productIdString
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                Alert.showAlert(on: self, with: "Shop Closed!", message: "Shop is closed.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else{
            return 130
        }
    }
}
