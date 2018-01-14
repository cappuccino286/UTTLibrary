//
//  LoginViewController2.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 14/01/2018.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            let userName = userNameInput.text
            let password = passwordInput.text
            let succeed = loginSucceeded(userName: userName!, password: password!)
            if !succeed {
                let alert = UIAlertController(title: "Failed", message: "Invalid username or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                    // use action here
                })
                self.present(alert, animated: true)
            }
            return succeed
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var viewController =  self.navigationController?.viewControllers
//        var nagivationControllerTemp = self.navigationController
//        var viewControllers = nagivationControllerTemp?.viewControllers
//        viewControllers?.remove(at: 0)
//        self.navigationController?.setViewControllers(viewControllers!, animated: true)
        
        // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
//        [navigationArray removeObjectAtIndex: 2];  // You can pass your index here
//        self.navigationController.viewControllers = navigationArray;
//        [navigationArray release];
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginSucceeded(userName : String, password : String) -> Bool{
        let database = LibraryPersistence.getInstance()
        let user = database.checkLogin(userName: userName, password: password)
        if user != nil {
            UserSessionManagement.saveUserSession(user: user!)
        }
        return user != nil
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
