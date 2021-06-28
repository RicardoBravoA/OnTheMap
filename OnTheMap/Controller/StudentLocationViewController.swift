//
//  StudentLocationViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import UIKit

class StudentLocationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiClient.studentLocation { response, error in
            DataModel.studentList = response
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
       if let urlString = urlString {
           if let url  = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
           }
       }
       return false
    }
    
}

extension StudentLocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as! StudentTableViewCell
        
        let student = DataModel.studentList[indexPath.row]
        
        cell.nameLabel.text = "\(student.firstName) \(student.lastName)"
        cell.urlLabel.text = student.mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = DataModel.studentList[indexPath.row]
        
        BrowserUtil.open(viewController: self, urlString: student.mediaURL)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
