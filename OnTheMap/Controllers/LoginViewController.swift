//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 19/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Always show this screen in light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        // Keyboard should be closed after tapping outside of text fields
        setShouldTapOnView(closeKeyboard: true)
        
        // Add some left padding to our text fields
        [ userNameField, passwordField ].forEach { field in
            field.addLeftPadding()
        }
    }

    @IBAction func onLoginButtonClicked() {
    }
    
    @IBAction func onSignUpButtonClicked() {
    }
}

