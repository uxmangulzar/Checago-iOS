//
//  CommunityNewsDetailVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/24/20.
//

import UIKit
import WebKit

class CommunityNewsDetailVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let siteLink = link else {
            return
        }
        
        if CheckInternet.Connection(){
            guard let url = URL(string: siteLink) else { return }

            let request = URLRequest(url: url)

            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    if let error = error {
                       print("\(error.localizedDescription)")
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Not Reachable!", message: "Sorry the site is not reachable.", preferredStyle: .alert)
                            
                            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { [weak self] (alert) in
                                self?.navigationController?.popViewController(animated: true)
                            }
                            alertView.addAction(alertAction)
                            self?.present(alertView, animated: true, completion: nil)
                        }
                   }
                   if let httpResponse = response as? HTTPURLResponse {
                       print("statusCode: \(httpResponse.statusCode)")
                       // do your logic here
                       // if statusCode == 200 ...
                        if httpResponse.statusCode == 200
                        {
                            let url = URL(string: siteLink)!
                            DispatchQueue.main.async {
                                self?.webView.load(URLRequest(url: url))
                                self?.webView.allowsBackForwardNavigationGestures = true
                            }
                        }
                   }
               }
               task.resume()
        }else{
            Alert.showInternetFailureAlert(on: self)
        }
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
