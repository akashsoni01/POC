//
//  gradient.swift
//  Speak Game
//
//  Created by Shobhit tyagi on 19/02/19.
//  Copyright © 2017 Shobhit tyagi. All rights reserved.
//

import UIKit

@IBDesignable
class gradient: UIView {
    @IBInspectable var firstcolor:UIColor = UIColor.clear
        {
            didSet
                {
                  updatecolor()
            }
    }
    @IBInspectable var Secondcolor:UIColor = UIColor.clear
        {
        didSet
        {
            updatecolor()
        }
    }
        override class var layerClass: AnyClass
        {
        get
        {
        return CAGradientLayer.self
        }
        }
    
    func updatecolor()
    {
        let layer = self.layer as? CAGradientLayer
        layer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer?.colors = [firstcolor.cgColor, Secondcolor.cgColor]
    }


}
class gradienttabbar: UITabBar {
    @IBInspectable var firstcolor:UIColor = UIColor.clear
        {
        didSet
        {
            updatecolor()
        }
    }
    @IBInspectable var Secondcolor:UIColor = UIColor.clear
        {
        didSet
        {
            updatecolor()
        }
    }
    override class var layerClass: AnyClass
        {
        get
        {
            return CAGradientLayer.self
        }
    }
    
    func updatecolor()
    {
        let layer = self.layer as? CAGradientLayer
        //layer?.frame = self.tintColor
        layer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer?.endPoint = CGPoint(x: 1.0, y: 0.5)
      
        layer?.colors = [firstcolor.cgColor, Secondcolor.cgColor]
      
       // self.layer.addSublayer(layer!)
        
    }
    
    
}
