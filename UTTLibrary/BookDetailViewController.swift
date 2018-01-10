//
//  ViewController.swift
//  UTTLibrary
//
//  Created by Sy Hung NGHIEM on 26/12/2017.
//  Copyright © 2017 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var book: Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            bookNameLabel.text = book.title
            authorLabel.text   = book.author
            descriptionLabel.text = book.description
            bookImageView.image = book.image     
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

