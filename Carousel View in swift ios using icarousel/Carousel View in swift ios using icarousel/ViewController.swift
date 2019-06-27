//
//  ViewController.swift
//  Carousel View in swift ios using icarousel
//
//  Created by Akash Soni on 27/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
// https://www.hackingwithswift.com/example-code/libraries/how-to-get-a-cover-flow-effect-on-ios
// https://github.com/akashsoni01/POC

import UIKit
class ViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        let carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        carousel.dataSource = self
        carousel.delegate = self
        carousel.type = .cylinder
        self.view.addSubview(carousel)
    }
    
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var labelView:UILabel?
        if view != nil{
            labelView = view as? UILabel
        }else{
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        }
        labelView?.text = "Hello"
        return labelView!
    }
    

}

