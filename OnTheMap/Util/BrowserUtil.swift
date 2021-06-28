//
//  BrowserUtil.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import UIKit

class BrowserUtil {
    
    static func open(viewController: UIViewController, urlString: String?) {
        
        if let url = URL(string: urlString ?? "") {
            if verifyUrl(urlString: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                AlertUtil.show(viewController: viewController, message: "URL not valid")
            }
        } else {
            AlertUtil.show(viewController: viewController, message: "URL not valid")
        }
        
    }
    
    static func verifyUrl (urlString: String?) -> Bool {
       if let urlString = urlString {
           if let url  = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
           }
       }
       return false
    }
    
}
