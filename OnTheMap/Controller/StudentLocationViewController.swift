//
//  StudentLocationViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import UIKit

class StudentLocationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension StudentLocationViewController: UITableViewDataSource, UITableViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let student = DataModel.studentList[indexPath.row]
        
        cell.textLabel?.text = movie.title
        if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "ticket")
        }
        
        if let posterPah = movie.posterPath {
            ApiClient.image(posterPath: posterPah) { data, error in
                guard let data = data else { return }
                cell.imageView?.image = UIImage(data: data)
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        print(selectedIndex)
    }
    
}
