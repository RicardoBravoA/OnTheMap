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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLocation()
        
        print(studentLocationRequest)
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
