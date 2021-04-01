//
//  LocationFetcherScreenViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 02/04/21.
//

import UIKit

class LocationFetcherScreenViewController: UIViewController {

    @IBOutlet weak var locationInputTextField: UITextField!
    
    @IBAction private func onCancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onFindTheMapButtonClicked(_ sender: Any) {
        // TODO: Implement later
    }
}
