//
//  iCarouselUsingIBOutletViewController.swift
//  Carousel View in swift ios using icarousel
//
//  Created by Akash Soni on 27/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class iCarouselUsingIBOutletViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {
    @IBOutlet weak var icarouselView: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icarouselView.delegate = self
        icarouselView.dataSource = self
        icarouselView.type = .coverFlow
        // Do any additional setup after loading the view.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView:UIImageView?
        if view != nil{
            imageView = view as? UIImageView
        }else{
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-80, height: 200))
        }
        imageView?.image = #imageLiteral(resourceName: "dummy")
        imageView?.contentMode = .scaleToFill
        return imageView!
    }
    


}
