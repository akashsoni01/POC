//
//  ViewController.swift
//  SafariViewForInstagramLogin
//
//  Created by Akash Soni on 27/05/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        //for open new safari app
        //        UIApplication.shared.openURL(NSURL(string: "http://instagram.com/")! as URL)
        //for same app
//        let svc = SFSafariViewController(url: URL(string:"http://instagram.com/akashsoni01")!)
//        svc.dismissButtonStyle = .close
//        self.present(svc, animated: true, completion: nil)
        let vc = SafariViewController(url: URL(string:"http://instagram.com/akashsoni01")!)
        self.present(vc, animated: true, completion: nil)

    }
    
}

