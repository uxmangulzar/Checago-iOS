//
//  SideMenuTableView.swift
//  ErrandDriverApp
//
//  Created by Tabish on 10/20/20.
//

import UIKit

class SideMenuTableView: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedLogoutBtn(_ sender: Any) {
        Alert.AskAlert(vc: self, title: "SignOut", message: "Are you sure you want to SignOut", trueTitle: "SignOut", falseTitle: "Cancel") { (result) in
            if result {
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.userId)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.userName)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.userImg)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.userEmail)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.jwt)

                let vc:LoginViewController = UIStoryboard.controller()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                self.view.resignFirstResponder()
            }
        }
    }
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
