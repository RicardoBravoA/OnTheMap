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
            self.reloadData()
        }
    }
    
    private func reloadData(){
        guard let mapViewController = viewControllers!.first as? MapViewController,
              let studentLocationViewController = viewControllers!.last as? StudentLocationViewController else {
            assertionFailure("Couldn't load view controllers.")
            return
        }
        
        mapViewController.loadData()
        studentLocationViewController.loadData()
    }
    
}
