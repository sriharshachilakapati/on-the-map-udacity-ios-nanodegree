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
        let request = SessionRequest(userName: userNameField.text!, password: passwordField.text!)
        
        showProgressIndicator {
            udacitySessionCreateApi.call(withPayload: request) { result in
                switch result {
                    case .success(let response):
                        AppSession.current = response.session
                        AppSession.userAccount = response.account
                        
                        udacityGetUserDataApi.call(withPathParameters: [ userIdPathParam: response.account!.key ]) { result in
                            self.hideProgressIndicator {
                                if case Result.failure(let error) = result {
                                    self.showAlertFor(error)
                                    return
                                }
                                
                                AppSession.userInfo = try? result.get()
                                
                                self.performSegue(withIdentifier: "toHomeScreen", sender: LoginViewController.self)
                            }
                        }

                    case .failure(let error):
                        self.hideProgressIndicator {
                            self.showAlertFor(error, withMessage: "Incorrect login credentials. Please check and try again.")
                        }
                }
            }
        }
    }
    
    @IBAction func onSignUpButtonClicked() {
    }
    
    @IBAction func onFormInputChanged(_ sender: Any) {
        loginButton.isEnabled = !(userNameField.text?.isEmpty ?? true) && !(passwordField.text?.isEmpty ?? true)
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.5
    }
}

