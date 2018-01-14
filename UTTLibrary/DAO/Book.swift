//
//  Book.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 10/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class Book{
    let title       : String
    let author : String
    let description : String
    let category    : Int64
    let image       : String?
    var user        : String
    // 1 if available and 0 if not
    var available   : Int64
    init(title:String,author:String,description:String,category:Int64,image: String?,available:Int64) {
        self.title=title
        self.author=author
        self.description=description
        self.category=category
        self.image=image
        self.available = available
        self.user = ""
    }
    
    init(title:String,author:String,description:String,category:Int64,image: String?,available:Int64, user : User) {
        self.title      = title
        self.author     = author
        self.description = description
        self.category   = category
        self.image      = image
        self.available  = available
        self.user       = user.userName
    }
    
    public func setAvailable(available : Bool) {
        if(available){
            self.available = 1
        }else{
            self.available = 0
        }
    }
    
    public func getAvailable() -> Int64{
        return self.available
    }
    
    public func isBorrowedByUser(user : User){
        self.user = user.userName
    }
    
    public func isRetoured(){
        self.user = ""
    }
    
}

