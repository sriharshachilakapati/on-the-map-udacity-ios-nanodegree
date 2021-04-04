//
//  UIViewControllerHelpers.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 21/03/21.
//

import UIKit

/**
 * Extensions doesn't allow us to define stored properties, and hence this trick of using a NSMapTable. This
 * class is like a Swift Dictionary, but gives more control over how the references are stored. I'm using weak
 * reference for keys so that when the ViewController is claimed by ARC, the entry in this map is also removed.
 */
fileprivate var uiViewControllerStateMap: NSMapTable<UIViewController, UIViewControllerExtensionState> = NSMapTable.weakToStrongObjects()

extension UIViewController {
    //MARK: - Extension state getter
    fileprivate var extensionState: UIViewControllerExtensionState {
        get {
            var state = uiViewControllerStateMap.object(forKey: self)
            
            if state == nil {
                state = UIViewControllerExtensionState()
                uiViewControllerStateMap.setObject(state, forKey: self)
            }
            
            return state!
        }
    }

    //MARK: - Keyboard extensions
    func setShouldTapOnView(closeKeyboard close: Bool) {
        var tapsRecognizer = extensionState.tapGestureRecognizer
        
        if tapsRecognizer == nil {
            tapsRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            
            extensionState.tapGestureRecognizer = tapsRecognizer
            view.addGestureRecognizer(tapsRecognizer!)
        }
        
        tapsRecognizer?.cancelsTouchesInView = false
        tapsRecognizer?.isEnabled = close
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - ViewController extensions
    func dismiss(levels: Int, animated: Bool, completion: (() -> Void)?) {
        var presentingVC = presentingViewController
        
        for _ in 1..<levels {
            presentingVC = presentingVC!.presentingViewController
        }
        
        presentingVC!.dismiss(animated: animated, completion: completion)
    }
    
    //MARK: - Progress indication extensions
    func showProgressIndicator(completion: @escaping () -> Void) {
        if extensionState.progressDialog != nil {
            return
        }
        
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.showProgressIndicator(completion: completion)
            }
            
            return
        }
        
        let progressDialog = self.storyboard?.instantiateViewController(withIdentifier: "ActivityIndicatorViewController")
        progressDialog?.modalPresentationStyle = .overCurrentContext
        progressDialog?.modalTransitionStyle = .crossDissolve
        extensionState.progressDialog = progressDialog
        
        
        self.present(progressDialog!, animated: true, completion: completion)
    }
    
    func hideProgressIndicator(completion: @escaping () -> Void = {}) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.hideProgressIndicator(completion: completion)
            }
            
            return
        }
        
        extensionState.progressDialog?.dismiss(animated: true) {
            self.extensionState.progressDialog = nil
            completion()
        }
    }
    
    //MARK: - Alerts
    func showAlertFor<T: Error> (_ error: T, withMessage message: String? = nil) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.showAlertFor(error)
            }
            
            return
        }
        
        let alertVC = UIAlertController(title: "Error", message: message ?? error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true, completion: nil)
        }))
        
        present(alertVC, animated: true, completion: nil)
    }
}
