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
    init(userName: userName, password : password, noEtu : noEtu){
        self.userName = userName
        self.password = password
        self.noEtu    = noEtu
    }
}
