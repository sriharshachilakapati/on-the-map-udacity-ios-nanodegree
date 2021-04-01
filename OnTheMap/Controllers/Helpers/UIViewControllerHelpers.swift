//
//  UIViewControllerHelpers.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 21/03/21.
//

import Foundation
import UIKit

/**
 * Extensions doesn't allow us to define stored properties, and hence this trick of using a NSMapTable. This
 * class is like a Swift Dictionary, but gives more control over how the references are stored. I'm using weak
 * reference for keys so that when the ViewController is claimed by ARC, the entry in this map is also removed.
 */
private var uiViewControllersMap: NSMapTable<UIViewController, UITapGestureRecognizer> = NSMapTable.weakToStrongObjects()

extension UIViewController {
    func setShouldTapOnView(closeKeyboard close: Bool) {
        var tapsRecognizer = uiViewControllersMap.object(forKey: self)
        
        if tapsRecognizer == nil {
            tapsRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            
            uiViewControllersMap.setObject(tapsRecognizer, forKey: self)
            view.addGestureRecognizer(tapsRecognizer!)
        }
        
        tapsRecognizer?.cancelsTouchesInView = false
        tapsRecognizer?.isEnabled = close
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func dismiss(levels: Int, animated: Bool, completion: (() -> Void)?) {
        var presentingVC = presentingViewController
        
        for _ in 1..<levels {
            presentingVC = presentingVC!.presentingViewController
        }
        
        presentingVC!.dismiss(animated: animated, completion: completion)
    }
}
