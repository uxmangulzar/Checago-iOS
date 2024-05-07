//
//  AllCommunityNewsVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/19/20.
//

import UIKit

class AllCommunityNewsVC: UIViewController, serverResponse {
    
    @IBOutlet weak var tableVu: UITableView!
    
    var newsModel = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_ALL_NEWS.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = ["user_id":userId,
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
        let allNews = json["all_news"] as! [[String: Any]]
        for singleNews in allNews {
            newsModel.append(NewsModel(json: singleNews))
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllCommunityNewsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityNewsCell", for: indexPath) as? CommunityNewsCell
        cell?.newsModel = newsModel[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: CommunityNewsDetailVC = UIStoryboard.controller()
        vc.link = self.newsModel[indexPath.item].newsLink
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
