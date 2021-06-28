//
//  AlertUtil.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import UIKit

class AlertUtil {
    
    static func show(viewController: UIViewController, message: String) {
        let alertController = UIAlertController(title: "On the Map", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
