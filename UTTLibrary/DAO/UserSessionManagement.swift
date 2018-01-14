//
//  UserSessionManagement.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 13/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import Foundation

class UserSessionManagement {
    static let USER_KEY = "currentUser"
    
    static func getUserSession() -> User{
        let preference = UserDefaults.standard
        return preference.object(forKey: UserSessionManagement.USER_KEY) as! User
    }
    static func saveUserSession(user : User){
        let preference = UserDefaults.standard
        preference.set(user, forKey: UserSessionManagement.USER_KEY)
        preference.synchronize()
    }
    
}
