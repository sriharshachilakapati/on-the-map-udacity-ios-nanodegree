//
//  UIViewHelpers.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 01/04/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: Float {
        get { Float(layer.cornerRadius) }
        set { layer.cornerRadius = CGFloat(newValue) }
    }
}
