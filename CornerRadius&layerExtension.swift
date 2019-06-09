//
//  CornerRadius&layerExtension.swift
//  Signup three screen in one
//
//  Created by Akash Soni on 09/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerradius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderwidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var bordercolor: UIColor? {
        get {
            //let color = UIColor.init(cgColor:layer.borderColor!)
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowradius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = shadowradius
        }
    }
}
