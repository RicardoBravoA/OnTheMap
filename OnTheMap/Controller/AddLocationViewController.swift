//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 28/06/21.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    private var studentLocationRequest: StudentLocationRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
        locationTextField.text = "Lima, Perú"
        websiteTextField.text = "http://google.com"
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: UIButton) {
        loading(true)
        let website = websiteTextField.text
        
        guard let location = locationTextField.text, location.isEmpty == false else {
            show(message: "Enter a valid location")
            loading(false)
            return
        }
        
        if !verifyUrl(urlString: website) {
            show(message: "Enter a valid website url")
            loading(false)
            return
        }
        
        geocode(location: location)
        
    }
    
    private func loading(_ loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.buttonEnabled(false, button: self.findLocationButton)
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.buttonEnabled(true, button: self.findLocationButton)
            }
        }
        DispatchQueue.main.async {
            self.locationTextField.isEnabled = !loading
            self.websiteTextField.isEnabled = !loading
            self.findLocationButton.isEnabled = !loading
        }
    }
    
    private func getStudentLocationRequest(coordinate: CLLocationCoordinate2D) {
        studentLocationRequest = StudentLocationRequest(uniqueKey: Auth.uniqueKey, firstName: Auth.firstName, lastName: Auth.lastName, mapString: locationTextField?.text ?? "", mediaURL: websiteTextField?.text ?? "", latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    private func geocode(location: String) {
        CLGeocoder().geocodeAddressString(location) { marker, error in
            if error != nil {
                self.show(message: "Location not found")
                self.loading(false)
            } else {
                guard let marker = marker else {
                    self.show(message: "Location not found")
                    self.loading(false)
                    return
                }
                
                var location: CLLocation?
                
                if marker.count > 0 {
                    location = marker.first?.location
                }
                
                self.loading(false)
                
                if let location = location {
                    print(location.coordinate)
                    self.getStudentLocationRequest(coordinate: location.coordinate)
                    self.performSegue(withIdentifier: "mapLocationSegue", sender: nil)
                } else {
                    self.show(message: "An error ocurred getting the coordinates")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapLocationSegue" {
            let viewController = segue.destination as! MapAddLocationViewController
            viewController.studentLocationRequest = studentLocationRequest
        }
    }
    
}
