//
//  EditProfileVC.swift
//  ChecagoCoffee
//
//  Created by Tabish on 12/24/20.
//

import UIKit
import GooglePlaces
import GooglePlacesSearchController

class EditProfileVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, serverResponse {
    
    @IBOutlet weak var profileImgBackVu: UIView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    var imageName: String?
    
    @IBOutlet weak var userNameVu: TextFieldCardView!
    @IBOutlet weak var emailVu: TextFieldCardView!
    @IBOutlet weak var phoneNumberVu: TextFieldCardView!
    @IBOutlet weak var addressVu: TextFieldCardView!
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var addressTF: UITextField!
    
    var userAddress: String?
    var userLat: String?
    var userLng: String?
    
    var zipCode: String?
    var state: String?
    var city: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.round()
        
        profileImgBackVu.layer.borderWidth = 2
        profileImgBackVu.layer.borderColor = UIColor.black.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSelectProfileImage))
        profileImgBackVu.isUserInteractionEnabled = true
        profileImgBackVu.addGestureRecognizer(tapGesture)
        
        userNameTF.delegate = self
        phoneNumberTF.delegate = self
        
        addressTF.delegate = self
        
        phoneNumberTF.keyboardType = .phonePad
        
        setPlaceholderColor()
        
        getUserProfile()
    }
    
    func getUserProfile(){
        if CheckInternet.Connection(){
            Utils.sharedInstance.startIndicator()
            let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
            let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
            
            let url = BaseUrls.baseUrl + "GET_USER_BY_USERID.php"
            let headers: [String:String] = [
            "Authorization": jwt
            ]
            let params : [String: Any] = ["user_id":userId]
            
            print("params are: \(params)")
            
            serverRequest.delegate = self
            serverRequest.postRequestWithRawData(url: url, header: headers, params: params, type: "")
        }else{
            Alert.showInternetFailureAlert(on: self)
        }
    }
    
    func onResponse(json: [String : Any], val: String) {
        if val == ""{
            print(json)
            let error = json["error"] as? Bool
            if error == false{
                let customerDetail = json["customer_details"] as! [[String: Any]]
                let userName = customerDetail[0]["user_name"] as? String
                let userImage = customerDetail[0]["user_image"] as? String
                let userEmail = customerDetail[0]["user_email"] as? String
                let userPhone = customerDetail[0]["user_phone"] as? String
                userAddress = customerDetail[0]["user_address"] as? String
                userLat = customerDetail[0]["user_lat"] as? String
                userLng = customerDetail[0]["user_lng"] as? String
                
                zipCode = customerDetail[0]["user_zip_code"] as? String
                city = customerDetail[0]["user_city"] as? String
                state = customerDetail[0]["user_state"] as? String
                
                DispatchQueue.main.async { [weak self] in
                    let imageUrl = BaseUrls.baseUrlImages + userImage!
                    print("imageUrl is: \(imageUrl)")
                    self?.profileImg.downloadImage(imageUrl: imageUrl)
                    self?.userNameTF.text = userName
                    self?.emailTF.text = userEmail
                    self?.phoneNumberTF.text = userPhone
                    self?.addressTextView.text = self?.userAddress
                }
            }
        }else if val == "edit_profile"{
            print(json)
            let status = json["status"] as? String
            if status == "200"{
                let result = json["result"] as? String
                let alertView = UIAlertController(title: "Success!", message: result, preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Okay", style: .cancel) { (alert) in
                    self.navigationController?.popViewController(animated: true)
                }
                alertView.addAction(alertAction)
                self.present(alertView, animated: true, completion: nil)
            }else{
                let message = json["message"] as? String
                Alert.showAlert(on: self, with: "Response Failed!", message: message ?? "")
            }
        }else if val == "upload_profile_image"{
            let status = json["status"] as? String
            if status == "200"{
                print("Profile Image Uploaded Successfully.")
            }
        }
        Utils.sharedInstance.stopIndicator()
    }
    
    @objc func tappedSelectProfileImage() {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.originalImage] as? UIImage else { return }
        
        guard let fileUrl = info[.imageURL] as? URL else { return }
        imageName = fileUrl.lastPathComponent
        
        self.profileImg.image = profileImage
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tappedUpdateProfile(_ sender: Any) {
        imageName = NSUUID().uuidString + ".jpg"
        if userNameTF.text != "" && emailTF.text != "" && phoneNumberTF.text != "" && addressTextView.text != "" && imageName != nil{
            if CheckInternet.Connection(){
                Utils.sharedInstance.startIndicator()
                
                let imgUrl = BaseUrls.baseUrl + "UPLOAD_FILES_NEW.php"
                let imgParams: [String: String] = ["type":"profile",
                                                   "file":imageName!]
                serverRequest.foamData(url: imgUrl, params: imgParams, image: profileImg.image, imageKey: "file", imageName: imageName!, type: "upload_profile_image")
                
                let userId:String = UserDefaults.standard.string(forKey: UserDefaultKey.userId)!
                let jwt:String = UserDefaults.standard.string(forKey: UserDefaultKey.jwt)!
                
                let headers: [String:String] = [
                "Authorization": jwt
                ]
                
                let url = BaseUrls.baseUrl + "UPDATE_CUSTOMER_PROFILE_BY_USERID.php"
                let params : [String: Any] = ["user_id":userId,
                                              "user_name":userNameTF.text!,
                                              "address":userAddress!,
                                              "lat":userLat!,
                                              "lng":userLng!,
                                              "zip_code":zipCode!,
                                              "state":state!,
                                              "city":city!,
                                              "phone_number":phoneNumberTF.text!,
                                              "files": [ ["file": imageName!] ]]
                
                print("params are: \(params)")
                
                serverRequest.delegate = self
                serverRequest.postRequestWithRawData(url: url, header: headers, params: params, type: "edit_profile")
            }else{
                Alert.showInternetFailureAlert(on: self)
            }
        }else{
            Alert.showAlert(on: self, with: "Fields Required!", message: "All Fields are required.")
        }
    }
}

extension EditProfileVC: GooglePlacesAutocompleteViewControllerDelegate{
    func viewController(didAutocompleteWith place: PlaceDetails) {
        addressTextView.text = place.formattedAddress
        zipCode = place.postalCode
        city = place.locality
        state = place.administrativeArea
        let searchLocation = place.coordinate!
        userAddress = place.formattedAddress
        userLat = String(place.coordinate!.latitude)
        userLng = String(place.coordinate!.longitude)
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.userNameTF{
            
            userNameVu.layer.borderWidth = 1
            userNameVu.layer.borderColor = UIColor.black.cgColor
        }else if textField == self.phoneNumberTF {
           
            phoneNumberVu.layer.borderWidth = 1
            phoneNumberVu.layer.borderColor = UIColor.black.cgColor
        }else if textField == self.addressTF {
            let controller = GooglePlacesSearchController(delegate: self,
                                                          apiKey: Google.googlePlacesApiKey,
                                                          placeType: .all
            )
            self.present(controller,animated: true)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.defaultStyle()
        return true
    }
    
    func defaultStyle(){
        userNameVu.layer.borderWidth = 0
        userNameVu.layer.borderColor = UIColor.clear.cgColor
        
        phoneNumberVu.layer.borderWidth = 0
        phoneNumberVu.layer.borderColor = UIColor.clear.cgColor
    }
}

extension EditProfileVC{
    func setPlaceholderColor(){
        userNameTF.attributedPlaceholder = NSAttributedString(string: "Change User Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        emailTF.attributedPlaceholder = NSAttributedString(string: "Change Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        phoneNumberTF.attributedPlaceholder = NSAttributedString(string: "Change Phone Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}
