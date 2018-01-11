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
            try sharedInstance.database.run(booksTable.insert(title <- "Détective Conan",author <- "Gosho Aoyama",description <- "Shinichi Kudo est un jeune détective lycéen âgé de 17 ans fréquemment associé avec la police. Lors d'une visite dans un parc d'attractions en compagnie de son amie d'enfance, Ran Mouri, il surprend discrètement une conversation privée entre deux individus appartenant à une mystérieuse organisation criminelle dont chaque membre est habillé en noir. Repéré puis assommé, il est contraint d'avaler un nouveau poison (l'APTX 4869) mis au point par cette organisation, avant d'être laissé pour mort.",category <- Int64(CATEGORY.COURT.rawValue), image <- "conan"))
            try sharedInstance.database.run(booksTable.insert(title <- "Clean Code",author <- "C.Martin Robert",description <- "Si un code sale peut fonctionner, il peut également remettre en question la pérennité d'une entreprise de développement de logiciels. Chaque année, du temps et des ressources sont gaspillés à cause d’un code mal écrit. Cet ouvrage vous apprendra les meilleures pratiques de nettoyage du code « à la volée » et les valeurs d’un artisan du logiciel qui feront de vous un meilleur programmeur.",category <- Int64(CATEGORY.COURT.rawValue), image <- "clean_code"))
            try sharedInstance.database.run(booksTable.insert(title <- "Naruto",author <- "Masashi Kishimoto",description <- "Naruto est un garçon un peu spécial. Solitaire au caractère fougueux, il n'est pas des plus appréciés dans son village. Malgré cela, il garde au fond de lui une ambition : celle de devenir un maître Hokage, la plus haute distinction dans l'ordre des ninjas, et ainsi obtenir la reconnaissance de ses pairs mais cela ne sera pas de tout repos... Suivez l'éternel farceur dans sa quête du secret de sa naissance et de la conquête des fruits de son ambition !",category <- Int64(CATEGORY.LONG.rawValue), image <- "naruto"))
            try sharedInstance.database.run(booksTable.insert(title <- "Dragon Ball",author <- "Akira Toriyama",description <- "Dragon Ball (ドラゴンボール, Doragon Bōru?, litt. Dragon Ball) est une série de mangas créée par Akira Toriyama, celui-ci s'inspirant librement du roman de Wu Cheng'en La Pérégrination vers l'Ouest. Elle est publiée pour la première fois dans le magazine Weekly Shōnen Jump de 1984 à 1995 et éditée en album de 1985 à 1995 par Shūeisha. Glénat publie l'édition française depuis février 1993.",category <- Int64(CATEGORY.COURT.rawValue), image <- "dragonball"))
            try sharedInstance.database.run(booksTable.insert(title <- "Doraemon",author <- "Fujiko Fujio",description <- "Doraemon (ドラえもん) est une série de mangas japonais, créée par Fujiko Fujio, par la suite devenue un anime puis une franchise médiatique. La série se centre sur un chat-robot nommé Doraemon, ayant voyagé à travers le temps depuis le futur, afin d'aider un jeune garçon nommé Nobita Nobi (野比 のび太, Nobi Nobita) .",category <- Int64(CATEGORY.LONG.rawValue), image <- "doremon"))
            try sharedInstance.database.run(booksTable.insert(title <- "Le Petit Prince",author <- "Fujiko Fujio",description <- "Le Petit Prince est une œuvre de langue française, la plus connue d'Antoine de Saint-Exupéry. Publié en 1943 à New York simultanément à sa traduction anglaise1, c'est un conte poétique et philosophique sous l'apparence d'un conte pour enfants.         Traduit à ce jour en 300 langues, Le Petit Prince est le deuxième ouvrage le plus traduit au monde après la Bible2.",category <- Int64(CATEGORY.LONG.rawValue), image <- "petit_prince"))
            try sharedInstance.database.run(booksTable.insert(title <- "One Piece",author <- "Eiichirō Oda",description <- "One Piece (ワンピース, Wan Pīsu?) est une série de mangas shōnen créée par Eiichirō Oda. Elle est prépubliée depuis le 22 juillet 1997 dans le magazine hebdomadaire Weekly Shōnen Jump, puis regroupée en volumes reliés aux éditions Shūeisha depuis le 24 décembre 1997. En novembre 2017, 87 tomes et plus de 880 chapitres sont commercialisées au Japon. La version française est publiée directement en volume reliés depuis le 1 septembre 2000 par Glénat. 85 volumes sont commercialisées en janvier 2018 en France. Depuis le 3 juillet 2013, une réédition plus proche de la version originale a été lancée.",category <- Int64(CATEGORY.LONG.rawValue), image <- "onepiece"))
        } catch {
            print(error)
        }
    }
}

