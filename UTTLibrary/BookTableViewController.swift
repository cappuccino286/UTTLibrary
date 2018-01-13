//
//  BookTableViewController.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 26/12/2017.
//  Copyright © 2017 Sy Hung NGHIEM. All rights reserved.
//

import UIKit
import SQLite

class BookTableViewController: UITableViewController {
    var books = [Book]()
    var model = LibraryPersistence.getInstance()
    private func loadSampleBooks() {
        do{
            print(try model.database.scalar(model.booksTable.count))
            for book in try model.database.prepare(model.booksTable) {
                let title = book[model.title]
                let description = book[model.description]
                let category = book[model.category]
                let image = book[model.image]
                books += [Book(title:title,description:description,category:category,image : image)]
            }
        } catch{
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            // App already launched
        } else {
            // This is the first launch ever
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            model.createTable()
            model.insertSampleBooks()
        }
        loadSampleBooks()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookTableViewCell else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }

        // Configure the cell...
        let book = books[indexPath.row]
        cell.bookNameLabel.text=book.title
        cell.bookImageView.image=UIImage(named: book.image!)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let bookDetailViewController = segue.destination as? BookDetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedBookCell = sender as? BookTableViewCell else {
            fatalError("Unexpected sender")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedBookCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedBook = books[indexPath.row]
        bookDetailViewController.book = selectedBook
    }

}
