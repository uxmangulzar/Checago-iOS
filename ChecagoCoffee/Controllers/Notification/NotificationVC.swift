//
//  NotificationVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/24/20.
//

import UIKit

class NotificationVC: UIViewController, serverResponse {
    
    @IBOutlet weak var tableVu: UITableView!
    
    var notificationModel = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNotifications()
    }
    
    func getNotifications(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_ALL_NOTIFICATIONS.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = [ "user_id":userId,
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
            let allNotifications = json["getnotification_result"] as! [[String: Any]]
            for singleNotification in allNotifications {
                notificationModel.append(NotificationModel(json: singleNotification))
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableVu.reloadData()
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
}

extension NotificationVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as? NotificationTableCell
        cell?.notificationModel = notificationModel[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
