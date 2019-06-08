//
//  ViewController.swift
//  JSONServiceHit
//
//  Created by Akash Soni on 08/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(ServiceManager.callApi())
    }


}

