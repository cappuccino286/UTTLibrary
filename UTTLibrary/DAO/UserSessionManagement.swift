//
//  UserSessionManagement.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 13/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import Foundation

class UserSessionManagement {
    static let USER_NAME = "currentUser"
    static let PASSWORD = "password"
    static let NOETU = "noetu"
    
    static func getUserSession() -> User{
        let preference = UserDefaults.standard
        let userName = preference.string(forKey: UserSessionManagement.USER_NAME)
        let password = preference.string(forKey: UserSessionManagement.PASSWORD)
        let noEtu = preference.string(forKey: UserSessionManagement.NOETU)
        return User(userName : userName!, password : password!, noEtu : noEtu!)
    }
    static func saveUserSession(user : User?){
        let preference = UserDefaults.standard
        preference.set(user?.userName, forKey: UserSessionManagement.USER_NAME)
        preference.set(user?.password, forKey: UserSessionManagement.PASSWORD)
        preference.set(user?.noEtu, forKey: UserSessionManagement.NOETU)
        preference.synchronize()
    }
    
}
