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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        pwdTextField.text = ""
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
        
        loading(true)
        
        ApiClient.login(user: email ?? "", pwd: pwd ?? "") { success, error in
            if success {
                self.loading(false)
                self.performSegue(withIdentifier: "dashboardSegue", sender: nil)
            } else {
                self.loading(false)
                self.show(message: error?.localizedDescription ?? "")
            }
        }
        
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        open(urlString: EndPoint.web.value)
    }
    
    func loading(_ loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.buttonEnabled(false, button: self.loginButton)
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.buttonEnabled(true, button: self.loginButton)
            }
        }
        DispatchQueue.main.async {
            self.emailTextField.isEnabled = !loading
            self.pwdTextField.isEnabled = !loading
            self.loginButton.isEnabled = !loading
            self.signUpButton.isEnabled = !loading
        }
    }
    
}

