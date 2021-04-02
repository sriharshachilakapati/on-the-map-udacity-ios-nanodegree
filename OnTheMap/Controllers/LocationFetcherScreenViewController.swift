//
//  LocationFetcherScreenViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 02/04/21.
//

import UIKit

class LocationFetcherScreenViewController: UIViewController {

    @IBOutlet weak var locationInputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShouldTapOnView(closeKeyboard: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    
    @IBAction private func onCancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toLinkCollectorScreen" else { return }
        
        let destinationVC = segue.destination as! LinkFetcherScreenViewController
        destinationVC.location = locationInputTextField.text ?? ""
    }
    
    @IBAction func onFindTheMapButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLinkCollectorScreen", sender: nil)
    }
}
