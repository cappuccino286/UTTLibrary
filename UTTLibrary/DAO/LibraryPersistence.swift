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
    var database : Connection! = nil
    enum CATEGORY: Int {
        case COURT  = 5
        case MOYEN  = 7
        case LONG   = 9
    }
    class func getInstance() -> LibraryPersistence{
        if(sharedInstance.database == nil){
            do {
                let documentDirectory = try FileManager.default.url(for: .documentDirectory,in: .userDomainMask, appropriateFor:nil, create:true)
                let fileUrl = documentDirectory.appendingPathComponent("user").appendingPathExtension("sqlite3")
                sharedInstance.database = try Connection(fileUrl.path)
                sharedInstance.createTables()
            } catch {
                print(error)
            }
        }
        return sharedInstance;
    }
    
    // table book
    struct BookContract {
        static let TABLE_NAME   = "books"
        static let BOOK_ID      = "id"
        static let BOOK_AUTHOR  = "author"
        static let BOOK_TITLE   = "title"
        static let BOOK_DESCRIPTION = "description"
        static let BOOK_CATEGORY = "category"
        static let BOOK_IMAGE   = "image"
        //static let BOOK_AVAILABLE = "available"
        static let BOOK_USER     = "user"
    }

    var booksTable  = Table(BookContract.TABLE_NAME)
    var id          = Expression<Int64>(BookContract.BOOK_ID)
    var author          = Expression<String>(BookContract.BOOK_AUTHOR)
    var title       = Expression<String>(BookContract.BOOK_TITLE)
    var description = Expression<String>(BookContract.BOOK_DESCRIPTION)
    var category    = Expression<Int64>(BookContract.BOOK_CATEGORY)
    var image       = Expression<String>(BookContract.BOOK_IMAGE)
    //var available   = Expression<Int64>(BookContract.BOOK_AVAILABLE)
    var user        = Expression<String>(BookContract.BOOK_USER)
    
    private func createTables(){
        createTableBook()
        createTableUser()
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            // App already launched
        } else {
            // This is the first launch ever
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            insertSamples()
        }
        
    }
    
    public func createTableBook(){
        do{
            try self.database.run(booksTable.create(ifNotExists: true)    { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(author)
                t.column(description)
                t.column(category)
                t.column(image)
                t.column(user)
            })
        } catch{
            print(error)
        }
    }
    
    // table User
    struct UserContract {
        static let TABLE_NAME       = "users"
        static let USER_NAME        = "userName"
        static let USER_PASSWORD    = "password"
        static let USER_NOETU       = "noEtu"
    }
    var userTable   = Table(UserContract.TABLE_NAME)
    var userName    = Expression<String>(UserContract.USER_NAME)
    var password    = Expression<String>(UserContract.USER_PASSWORD)
    var noEtu       = Expression<String>(UserContract.USER_NOETU)
    
    public func createTableUser(){
        do{
            try sharedInstance.database.run(userTable.create(ifNotExists: true)    { t in
                t.column(userName, primaryKey: true)
                t.column(password)
                t.column(noEtu)
            })
        } catch{
            print(error)
        }
    }
    
    // table Author
    /*struct AuthorContract {
        static let TABLE_NAME       = "authors"
        static let AUTHOR_ID        = "id"
        static let AUTHOR_NOM       = "nom"
        static let AUTHOR_PRENOM    = "prenom"
        
    }
    var authorTable = Table(UserContract.TABLE_NAME)
    var authorId    = Expression<Int64>(AuthorContract.AUTHOR_ID)
    var authorNom   = Expression<String>(AuthorContract.AUTHOR_NOM)
    var authorPrenom = Expression<String>(AuthorContract.AUTHOR_PRENOM)
    
    public func createTableAuthor(){
        do{
            try sharedInstance.database.run(authorTable.create(ifNotExists: true)    { t in
                t.column(authorId, primaryKey: true)
                t.column(authorNom)
                t.column(authorPrenom)
            })
        } catch{
            print(error)
        }
    }
    
    // table book_author
    struct BookAuthorContract {
        static let TABLE_NAME       = "book_author"
        static let BA_ID_BOOK       = "id_book"
        static let BA_ID_AUTHOR     = "id_author"
    }
    var bookAuthorTable = Table(BookAuthorContract.TABLE_NAME)
    var ba_idBook       = Expression<Int64>(BookAuthorContract.BA_ID_BOOK)
    var ba_idAuthor     = Expression<Int64>(BookAuthorContract.BA_ID_AUTHOR)

    public func createTableBookAuthor(){
        do{
            try sharedInstance.database.run(bookAuthorTable.create(ifNotExists: true) { t in
                t.column(ba_idBook)
                t.column(ba_idAuthor)
            })
        } catch{
            print(error)
        }
    }*/
    public func insertSamples(){
        do{
            let user1 = User(userName: "lampham", password: "123456", noEtu: "37491")
            let user2 = User(userName: "syhung", password: "123456", noEtu: "37491")
            let user3 = User(userName: "kingboya", password: "123456", noEtu: "37491")
            let user4 = User(userName: "cappuccino", password: "123456", noEtu: "37491")
            let user5 = User(userName: "lamphama2", password: "123456", noEtu: "37491")
            
            insertUser(user : user1)
            insertUser(user : user2)
            insertUser(user : user3)
            insertUser(user : user4)
            insertUser(user : user5)
            
            var conanBook = Book(title : "Détective Conan",author : "Gosho Aoyama", description : "Shinichi Kudo est un jeune détective lycéen âgé de 17 ans fréquemment associé avec la police. Lors d'une visite dans un parc d'attractions en compagnie de son amie d'enfance, Ran Mouri, il surprend discrètement une conversation privée entre deux individus appartenant à une mystérieuse organisation criminelle dont chaque membre est habillé en noir. Repéré puis assommé, il est contraint d'avaler un nouveau poison (l'APTX 4869) mis au point par cette organisation, avant d'être laissé pour mort.", category : Int64(CATEGORY.COURT.rawValue), image :"conan", user : user1.userName)
            
            self.insertBook(book : conanBook)
          
            var cleanCodeBook = Book(title : "Clean Code",author : "C.Martin Robert", description : "Si un code sale peut fonctionner, il peut également remettre en question la pérennité d'une entreprise de développement de logiciels. Chaque année, du temps et des ressources sont gaspillés à cause d’un code mal écrit. Cet ouvrage vous apprendra les meilleures pratiques de nettoyage du code « à la volée » et les valeurs d’un artisan du logiciel qui feront de vous un meilleur programmeur.", category : Int64(CATEGORY.LONG.rawValue), image : "clean_code",user : user1.userName)
            self.insertBook(book : cleanCodeBook)

            
            var narutoBook = Book(title : "Naruto",author : "Masashi Kishimoto", description : "Naruto est un garçon un peu spécial. Solitaire au caractère fougueux, il n'est pas des plus appréciés dans son village. Malgré cela, il garde au fond de lui une ambition : celle de devenir un maître Hokage, la plus haute distinction dans l'ordre des ninjas, et ainsi obtenir la reconnaissance de ses pairs mais cela ne sera pas de tout repos... Suivez l'éternel farceur dans sa quête du secret de sa naissance et de la conquête des fruits de son ambition !",category : Int64(CATEGORY.LONG.rawValue), image : "naruto", user : user1.userName)
            self.insertBook(book : narutoBook)
     

            var dragonBallBook = try Book(title : "Dragon Ball",author : "Akira Toriyama", description : "Dragon Ball (ドラゴンボール, Doragon Bōru?, litt. Dragon Ball) est une série de mangas créée par Akira Toriyama, celui-ci s'inspirant librement du roman de Wu Cheng'en La Pérégrination vers l'Ouest. Elle est publiée pour la première fois dans le magazine Weekly Shōnen Jump de 1984 à 1995 et éditée en album de 1985 à 1995 par Shūeisha. Glénat publie l'édition française depuis février 1993.",category : Int64(CATEGORY.COURT.rawValue), image : "dragonball",user : user1.userName)
            self.insertBook(book : dragonBallBook)

            var doraemonBook = try Book(title : "Doraemon",author : "Fujiko Fujio", description : "Doraemon (ドラえもん) est une série de mangas japonais, créée par Fujiko Fujio, par la suite devenue un anime puis une franchise médiatique. La série se centre sur un chat-robot nommé Doraemon, ayant voyagé à travers le temps depuis le futur, afin d'aider un jeune garçon nommé Nobita Nobi (野比 のび太, Nobi Nobita) .",category : Int64(CATEGORY.LONG.rawValue), image : "doremon")
            self.insertBook(book : doraemonBook)
    
            var petitPrinceBook = Book(title : "Le Petit Prince",author : "Antoine Saint-Exupéry", description: "Le Petit Prince est une œuvre de langue française, la plus connue d'Antoine de Saint-Exupéry. Publié en 1943 à New York simultanément à sa traduction anglaise1, c'est un conte poétique et philosophique sous l'apparence d'un conte pour enfants.         Traduit à ce jour en 300 langues, Le Petit Prince est le deuxième ouvrage le plus traduit au monde après la Bible2.",category : Int64(CATEGORY.LONG.rawValue), image : "petit_prince")
            self.insertBook(book : petitPrinceBook)
            
            var onepieceBook = Book(title : "One Piece",author : "Eiichirō Oda", description : "One Piece (ワンピース, Wan Pīsu?) est une série de mangas shōnen créée par Eiichirō Oda. Elle est prépubliée depuis le 22 juillet 1997 dans le magazine hebdomadaire Weekly Shōnen Jump, puis regroupée en volumes reliés aux éditions Shūeisha depuis le 24 décembre 1997. En novembre 2017, 87 tomes et plus de 880 chapitres sont commercialisées au Japon. La version française est publiée directement en volume reliés depuis le 1 septembre 2000 par Glénat. 85 volumes sont commercialisées en janvier 2018 en France. Depuis le 3 juillet 2013, une réédition plus proche de la version originale a été lancée.",category : Int64(CATEGORY.LONG.rawValue), image : "onepiece")
            self.insertBook(book : onepieceBook)
           
        } catch {
            print(error)
        }
    }
    
    // return the inserted id
    func insertBook(book : Book) -> Int64{
        do {
            var insert = booksTable.insert(title <- book.title, author <- book.author, description <- book.description, category <- book.category, image <- book.image!, user <- book.user)
            let idInserted = try self.database.run(insert)
            return idInserted
        } catch  {
            print(error)
            return -1
        }
    }
    
    func insertUser(user : User){
        do {
            try self.database.run(userTable.insert(self.userName <- user.userName, self.password <- user.password, self.noEtu <- user.noEtu))
        } catch {
            print(error)
        }
    }
    /*
    func insertAuthor(author : Author) -> Int64{
        do {
            return try sharedInstance.database.run(authorTable.insert(self.authorNom <- author.nom, self.authorPrenom <- author.prenom))
        } catch  {
            print(error)
            return -1
        }
        
    }
    
    func insertBookAuthor(book : Book, author : Author){
        let idBook =  insertBook(book: book)
        let idAuthor =  insertAuthor(author: author)
            insertBookAuthor(idBook : idBook, idAuthor : idAuthor)
    }
    
    func insertBookAuthor(idBook :Int64, idAuthor: Int64){
        do{
            try sharedInstance.database.run(self.bookAuthorTable.insert(ba_idBook <- idBook, self.ba_idAuthor <- idAuthor))
        }catch {
            print(error)
        }
    }*/

    func checkLogin(userName : String, password : String) -> User? {
        do{
            var user : User?
            user = nil
            for resultat in try database.prepare(self.userTable.filter(self.userName == userName && self.password == password)){
                user = User(userName : resultat[self.userName], password : resultat[self.password], noEtu : resultat[self.noEtu])
            }
            return user
                
        }catch {
            print(error)
        }
        return nil
    }
    
    public func deleteBook(book : Book) {
        let bookToDelete = booksTable.filter(self.title == book.title && self.author == book.author)
        do {
            try self.database.run(bookToDelete.delete())
        } catch {
            print(error)
        }
    }
    
}

