//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 31/03/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parentVC = tabBarController as! OnTheMapTabViewController
        parentVC.fetchLocations {
            DispatchQueue.main.async {
                self.reloadMapPins()
            }
        }
    }
    
    private func reloadMapPins() {
        let parentVC = tabBarController as! OnTheMapTabViewController
        
        mapView.removeAnnotations(mapView.annotations)
        
        parentVC.locationsResponse?.results.forEach { location in
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            annotation.coordinate = coordinate
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = location.mediaURL
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "PinMapView"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView?.canShowCallout = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        
        pinView?.displayPriority = .required
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            UIApplication.shared.open(URL(string: view.annotation!.subtitle!!)!, options: [:], completionHandler: nil)
        }
    }
}
