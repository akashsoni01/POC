//
//  ViewController.swift
//  CustomWebView
//
//  Created by Akash Soni on 28/05/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CustomWebViewController") as! CustomWebViewController
        //add your url path here
        vc.url = URL(string: "https://dev.allcareapp.com/tgh-test/register/?view=mobile")
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}

struct testingController {
    
}
