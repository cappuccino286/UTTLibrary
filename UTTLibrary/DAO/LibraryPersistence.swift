//
//  LibraryPersistence.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 09/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit
import SQLite

let sharedInstance = LibraryPersistence()
class LibraryPersistence{
    struct BookContract {
        static let TABLE_NAME = "books"
        static let BOOK_ID = "id"
        static let BOOK_TITLE = "title"
        static let BOOK_AUTHOR = "author"
        static let BOOK_DESCRIPTION = "description"
        static let BOOK_CATEGORY = "category"
        static let BOOK_IMAGE = "image"
    }
    enum CATEGORY: Int {
        case COURT = 5
        case MOYEN = 7
        case LONG = 9
    }
    var database : Connection! = nil
    var booksTable = Table(BookContract.TABLE_NAME)
    var id = Expression<Int64>(BookContract.BOOK_ID)
    var title = Expression<String>(BookContract.BOOK_TITLE)
    var author = Expression<String>(BookContract.BOOK_AUTHOR)
    var description = Expression<String>(BookContract.BOOK_DESCRIPTION)
    var category = Expression<Int64>(BookContract.BOOK_CATEGORY)
    var image = Expression<String>(BookContract.BOOK_IMAGE)
    class func getInstance() -> LibraryPersistence{
        if(sharedInstance.database == nil){
            do {
                let documentDirectory = try FileManager.default.url(for: .documentDirectory,in: .userDomainMask, appropriateFor:nil, create:true)
                let fileUrl = documentDirectory.appendingPathComponent("user").appendingPathExtension("sqlite3")
                sharedInstance.database = try Connection(fileUrl.path)
                
            } catch {
                print(error)
            }
        }
        return sharedInstance;
    }
    public func createTable(){
        do{
            try sharedInstance.database.run(booksTable.create(ifNotExists: true)    { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(author)
                t.column(description)
                t.column(category)
                t.column(image)
            })
        } catch{
            print(error)
        }
    }
    public func insertSampleBooks(){
        do{
            try sharedInstance.database.run(booksTable.insert(title <- "Conan",author <- "Gosho Aoyama",description <- "Conan",category <- Int64(CATEGORY.COURT.rawValue), image <- "conan"))
            try sharedInstance.database.run(booksTable.insert(title <- "Clean Code",author <- "C.Martin Robert",description <- "Clean Code",category <- Int64(CATEGORY.COURT.rawValue), image <- "conan"))
            try sharedInstance.database.run(booksTable.insert(title <- "Doremon",author <- "Sy Hung",description <- "Doremon",category <- Int64(CATEGORY.LONG.rawValue), image <- "harry_potter"))
            try sharedInstance.database.run(booksTable.insert(title <- "Dragon Ball",author <- "Lam Pham",description <- "Dragon Ball",category <- Int64(CATEGORY.COURT.rawValue), image <- "dragon_ball"))
            try sharedInstance.database.run(booksTable.insert(title <- "Harry Potter",author <- "J.K Rowling",description <- "Harry Potter",category <- Int64(CATEGORY.LONG.rawValue), image <- "harry_potter"))
        } catch {
            print(error)
        }
    }
}

