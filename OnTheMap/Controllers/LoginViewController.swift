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
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func onLoginButtonClicked() {
    }
    
    @IBAction func onSignUpButtonClicked() {
    }
    
    @IBAction func onUserNameInputChanged(_ sender: Any) {
        loginButton.isEnabled = userNameField.text?.hasSuffix("@udacity.com") ?? false
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.5
    }
}

