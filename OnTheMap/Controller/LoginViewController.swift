//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 26/06/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }

    @IBAction func login(_ sender: UIButton) {
        let email = emailTextField.text
        let pwd = pwdTextField.text
        
        if email?.isEmpty == true {
            show(message: "Enter Email")
            return
        }
        
        if pwd?.isEmpty == true {
            show(message: "Enter Password")
            return
        }
        
        ApiClient.login(user: email ?? "", pwd: pwd ?? "") { success, error in
            if success {
                self.performSegue(withIdentifier: "dashboardSegue", sender: nil)
            } else {
                self.show(message: error?.localizedDescription ?? "")
            }
        }
        
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        open(urlString: EndPoint.web.value)
    }
    
}

