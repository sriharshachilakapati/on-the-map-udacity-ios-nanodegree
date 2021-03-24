//
//  UITextFieldHelpers.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 24/03/21.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding() {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = .always
    }
}
