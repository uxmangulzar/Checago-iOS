//
//  Constants.swift
//  deliveriance
//
//  Created by Zeeshan Ashraf on 06/03/2020.
//  Copyright © 2020 SigiTechnologies. All rights reserved.
//

import Foundation

struct BaseUrls{
    
    static let baseUrl = "https://usmandev.website/chicago-app/Functions/"
    static let baseUrlImages = "https://usmandev.website/chicago-app/"
}

// MARK: - Google Keys
struct Google {
    static let googlePlacesApiKey = "AIzaSyAWD3r8_xNLfwvjlpSvXc_FPgBRncfHXg4"
    static let gmsServiceApiKey = "AIzaSyAWD3r8_xNLfwvjlpSvXc_FPgBRncfHXg4"
}

struct UserDefaultKey {
    static let userId = "userId"
    static let userImg = "userImg"
    static let userName = "userName"
    static let userEmail = "userEmail"
    static let jwt = "jwt"
    static let checkLoginStatus = "loginStatus"
    static let driverSearching = "driverSearching"
    static let requestId = "requestId"
}

// MARK: - Messages
struct Message {
    static let warning = "Warning"
    static let call = "You device not supported calls at the moment"
}
