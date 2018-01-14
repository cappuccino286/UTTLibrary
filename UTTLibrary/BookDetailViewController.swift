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
    var book: Book?
    var bookTitle:String = ""
    var similarBooks = [Book]()
    var model = LibraryPersistence.getInstance()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var borrowButton: UIButton!
    var thisUser:String = UserSessionManagement.getUserSession().userName
    @IBAction func borrowButtonAction(_ sender: UIButton) {
        setStateButton(state: thisUser)
        do{
            let targetBook = model.booksTable.filter(model.title == bookTitle)
            try model.database.run(targetBook.update(model.user <- thisUser))
        } catch{
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarBooks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.similarBookImage.image = UIImage(named : similarBooks[indexPath.row].image!)
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
                let user = book[model.user]
                similarBooks += [Book(title:title,author:author,description:description,category:category,image:image,user:user)]
            }
        } catch{
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let book = book {
            navigationItem.title = book.title
            authorLabel.text = book.author
            bookNameLabel.text = book.title
            descriptionLabel.text = book.description
            bookImageView.image = UIImage(named: book.image!)
        }
        setStateButton(state: (book?.user)!)
        bookTitle = (book?.title)!
        loadSmilarBooks(title: (book?.title)!)
    }	
    private func setStateButton(state : String){
        if state.isEmpty{
            borrowButton.setTitle("Borrow", for: UIControlState.normal)
            borrowButton.backgroundColor = UIColor(red: 253/255, green: 142/255, blue: 9/255, alpha: 1.0)
            borrowButton.isEnabled = true
            
        } else{
            borrowButton.setTitle("Borrowed", for: UIControlState.normal)
            borrowButton.backgroundColor = UIColor(red: 74/255, green: 49/255, blue: 42/255, alpha: 1.0)
            borrowButton.isEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

