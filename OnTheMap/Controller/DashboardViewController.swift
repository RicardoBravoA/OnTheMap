//
//  DashboardViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 28/06/21.
//

import UIKit

class DashboardViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiClient.studentLocation { response, error in
            DataModel.studentList = response
        }
    }
    
}
