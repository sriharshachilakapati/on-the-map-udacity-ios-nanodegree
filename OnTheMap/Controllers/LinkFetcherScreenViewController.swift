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
                return
            }
            
            DispatchQueue.main.async {
                let annotation = MKPointAnnotation()
                annotation.coordinate = place
                annotation.title = self.location
                
                self.mapView.addAnnotation(annotation)
            }
        }
    }

    @IBAction func onCancelButtonClicked() {
        dismiss(levels: 2, animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButtonClicked() {
        // TODO: Implement later
    }
}
