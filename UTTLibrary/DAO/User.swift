//
//  User.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 1/11/18.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import Foundation
class User {
    let userName : String
    let password : String
    let noEtu    : String
    init(userName: String, password : String, noEtu : String){
        self.userName = userName
        self.password = password
        self.noEtu    = noEtu
    }
    public var description : String {
        return userName
    }
    
}
