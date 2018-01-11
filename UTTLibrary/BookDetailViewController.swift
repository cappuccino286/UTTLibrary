//
//  ViewController.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 26/12/2017.
//  Copyright © 2017 Sy Hung NGHIEM. All rights reserved.
//

import UIKit
import SQLite
class BookDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var book: Book?
    var similarBooks = [Book]()
    var model = LibraryPersistence.getInstance()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarBooks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.similarBookImage.image = similarBooks[indexPath.row].image
        cell.similarBookLabel.text = similarBooks[indexPath.row].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController)
        let selectedBook = similarBooks[indexPath.row]
        vc.book = selectedBook
        self.navigationController?.show(vc, sender: vc.book)
    }
    
    private func loadSmilarBooks(title: String) {
        do{
            for book in try model.database.prepare(model.booksTable.filter(model.title != title)) {
                let title = book[model.title]
                let author = book[model.author]
                let description = book[model.description]
                let category = book[model.category]
                let image = book[model.image]
                similarBooks += [Book(title:title,author:author,description:description,category:category,image:UIImage(named:image))]
            }
        } catch{
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            bookNameLabel.text = book.title
            authorLabel.text   = book.author
            descriptionLabel.text = book.description
            bookImageView.image = book.image     
        }
        loadSmilarBooks(title: (book?.title)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

