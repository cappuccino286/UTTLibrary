//
//  BookConsultingViewController.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 14/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class BookConsultingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var listBookCollectionView: UICollectionView!
    var allBookList = [Book]()
    var model = LibraryPersistence.getInstance()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookConsultingCell", for: indexPath) as! BookItemCollectionViewCell
        let position = indexPath.row
        cell.bookImageView.image = UIImage(named : allBookList[indexPath.row].image!)
        cell.bookTitleField.text = allBookList[position].title
        cell.authorField.text    = allBookList[position].author
        cell.deleteButton.tag = position
        cell.deleteButton.addTarget(self, action : #selector(self.deleteItem), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    @IBAction func deleteItem(sender : UIButton) -> Void{
        let idBook = sender.tag
        let book = allBookList[idBook]
        self.deleteBook(book: book)
        self.reloadBook()
        self.listBookCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if (!segue.destination.isKind(of: BookDetailViewController.self) ){
            return
        }
        let bookDetailViewController = segue.destination as? BookDetailViewController
        guard let selectedBookCell = sender as? BookItemCollectionViewCell else {
            fatalError("Unexpected sender")
        }
            
        guard let indexPath = listBookCollectionView.indexPath(for: selectedBookCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
            
        let selectedBook = allBookList[indexPath.row]
        bookDetailViewController?.book = selectedBook

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadBook()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadBook() {
        //clear list before reloading
        allBookList.removeAll()
        do{
            for book in try model.database.prepare(model.booksTable) {
                let title = book[model.title]
                //                let author = book[model.author]
                let description = book[model.description]
                let category = book[model.category]
                let image = book[model.image]
                let author = book[model.author]
                let user = book[model.user]
                allBookList += [Book(title:title, author : author, description:description, category:category,image:image, user: user)]
            }
        } catch{
            print(error)
        }
    }
    
    func deleteBook(book : Book){
        let model = LibraryPersistence.getInstance()
        model.deleteBook(book : book)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
