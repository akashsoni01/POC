//
//  ViewController.swift
//  ButtonAnimationOnTapExtension
//
//  Created by Akash Soni on 29/05/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pulsate(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func flash(_ sender: UIButton) {
        sender.flash()
    }
    
    @IBAction func shake(_ sender: UIButton) {
        sender.shake()
    }
    @IBAction func scaleAnimate(_ sender: UIButton) {
        sender.scalAnimate()
    }
    @IBAction func positionAnimation(_ sender: UIButton) {
        sender.positionAnimation()
    }
}

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    func scalAnimate(){
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = 1
        animation.toValue = 2
        animation.autoreverses = true
        layer.add(animation, forKey: "position")
    }
    func positionAnimation(){
        //dummy
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.5
        animation.fromValue = [0, 0]
        animation.toValue = [100, 100]
        animation.autoreverses = true
        layer.add(animation, forKey: "position")
    }
}
