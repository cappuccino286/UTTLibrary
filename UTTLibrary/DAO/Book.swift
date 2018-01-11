//
//  Book.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 10/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class Book{
    var title: String
    var author: String
    var description: String
    var category: Int64
    var image: UIImage?
    init(title:String,author:String,description:String,category:Int64,image: UIImage?) {
        self.title=title
        self.author=author
        self.description=description
        self.category=category
        self.image=image
    }
    
}

