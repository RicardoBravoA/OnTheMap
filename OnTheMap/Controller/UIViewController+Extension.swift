//
//  UIViewController+Extension.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import UIKit

extension UIViewController {
    
    func open(urlString: String?) {
        
        if let url = URL(string: urlString ?? "") {
            if verifyUrl(urlString: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                show(message: "URL not valid")
            }
        } else {
            show(message: "URL not valid")
        }
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
       if let urlString = urlString {
           if let url  = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
           }
       }
       return false
    }
    
    func show(message: String) {
        let alertController = UIAlertController(title: "On the Map", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
