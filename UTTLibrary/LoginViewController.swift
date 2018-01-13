//
//  LoginViewController.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 12/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        let userName = userNameInput.text
        let password = passwordInput.text
        if loginSucceeded(userName: userName!, password: password!) {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginSucceeded(userName : String, password : String) -> Bool{
        let database = LibraryPersistence.getInstance()
        return database.checkLogin(userName: userName, password: password)
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
