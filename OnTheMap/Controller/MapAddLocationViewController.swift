//
//  MapAddLocationViewController.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import UIKit
import MapKit

class MapAddLocationViewController: UIViewController {
    
    var studentLocationRequest: StudentLocationRequest?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLocation()
    }
    
    private func showLocation() {
        if let student = studentLocationRequest {
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.title = student.mapString
            annotation.coordinate = CLLocationCoordinate2DMake(student.latitude, student.longitude)
            
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    @IBAction func finishAction(_ sender: Any) {
        loading(true)
        
        guard let student = studentLocationRequest else {
            show(message: "An error occurred getting student info")
            loading(false)
            return
        }
        
        if Auth.objectId.isEmpty {
            ApiClient.addStudentLocation(studentLocation: student) { success, error in
                if success {
                    self.loading(false)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.loading(false)
                    self.show(message: error?.localizedDescription ?? "")
                }
            }
        } else {
            ApiClient.updateStudentLocation(studentLocation: student) { success, error in
                if success {
                    self.loading(false)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.loading(false)
                    self.show(message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func loading(_ loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            loading ? self.buttonEnabled(false, button: self.finishButton) : self.buttonEnabled(true, button: self.finishButton)
            self.finishButton.isEnabled = !loading
        }
    }
}

extension MapAddLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
