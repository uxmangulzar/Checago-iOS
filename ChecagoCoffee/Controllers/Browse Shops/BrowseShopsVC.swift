//
//  BrowseShopsVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class BrowseShopsVC: UIViewController, serverResponse {
    
    @IBOutlet weak var tableVu: UITableView!
    
    var shopModel = [BrowseShopsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllData()
    }
    
    func getAllData(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_SHOPS_BY_SUBCATID.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = ["user_id":userId,
                                          "sub_cat_id":"1",
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
        let allShops = json["all_shops"] as! [[String: Any]]
        for singleShop in allShops {
            shopModel.append(BrowseShopsModel(json: singleShop))
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableVu.reloadData()
        }
        Utils.sharedInstance.stopIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            self?.tableVu.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BrowseShopsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowseShopTableCell", for: indexPath) as? BrowseShopTableCell
        cell?.shopModel = shopModel[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: NearByCoffeeDetailVC = UIStoryboard.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

