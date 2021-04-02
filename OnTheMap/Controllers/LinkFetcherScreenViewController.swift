//
//  LinkFetcherScreenViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 02/04/21.
//

import UIKit
import MapKit

class LinkFetcherScreenViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var linkInputTextField: UITextField!
    
    var location: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setShouldTapOnView(closeKeyboard: true)

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            guard let place = placemarks?.first?.location?.coordinate else {
                print(error!)
                
                let alertVC = UIAlertController(title: "Unable to find location",
                                                message: "The location you have entered is invalid. Please tap on OK to retry.",
                                                preferredStyle: .alert)
                
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            
            DispatchQueue.main.async {
                let annotation = MKPointAnnotation()
                annotation.coordinate = place
                annotation.title = self.location
                self.mapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: place, latitudinalMeters: 10000, longitudinalMeters: 10000)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    @IBAction func onCancelButtonClicked() {
        dismiss(levels: 2, animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButtonClicked() {
        // TODO: Implement later
    }
}
