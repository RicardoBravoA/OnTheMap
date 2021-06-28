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
        
        getStudentList()
    }
    
    private func getStudentList() {
        ApiClient.studentLocation { response, error in
            DataModel.studentList.removeAll()
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
    
    @IBAction func reloadData(_ sender: UIBarButtonItem) {
        getStudentList()
    }
}
