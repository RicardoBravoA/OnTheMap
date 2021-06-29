//
//  DashboardViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 28/06/21.
//

import UIKit

class DashboardViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    @IBAction func addLocation(_ sender: Any) {
        if Auth.objectId.isEmpty {
            self.performSegue(withIdentifier: "addLocationSegue", sender: nil)
        } else {
            let alertController = UIAlertController(title: "", message: "You have already posted a student location. Would you like to overwrite your current location?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: { action in
                self.performSegue(withIdentifier: "addLocationSegue", sender: nil)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(alertController, animated: true)
        }
    }
    
}
