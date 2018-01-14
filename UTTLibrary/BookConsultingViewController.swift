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
        cell.bookImageView.image = UIImage(named : allBookList[indexPath.row].image!)
        cell.bookTitleField.text = allBookList[indexPath.row].title
        cell.authorField.text    = allBookList[indexPath.row].author
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBook()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadBook() {
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
                let available = book[model.available]
                allBookList += [Book(title:title, author : author, description:description, category:category,image:image, available: available)]
            }
        } catch{
            print(error)
        }
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
