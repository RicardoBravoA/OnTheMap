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
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: UIButton) {
        let email = emailTextField.text
        let pwd = pwdTextField.text
        
        if email?.isEmpty == true {
            alertError(message: "Enter Email")
            return
        }
        
        if pwd?.isEmpty == true {
            alertError(message: "Enter Password")
            return
        }
        
        ApiClient.login(user: email ?? "", pwd: pwd ?? "") { success, error in
            if success {
                self.performSegue(withIdentifier: "dashboardSegue", sender: nil)
            } else {
                self.alertError(message: error?.localizedDescription ?? "")
            }
        }
        
    }
    
    private func alertError(message: String) {
        let alertController = UIAlertController(title: "On The Map", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertController, sender: nil)
    }
    
}

