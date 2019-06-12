//
//  ViewController.swift
//  NotificationCenter in swift
//
//  Created by Akash Soni on 12/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//remember define and add the notification in same viewcontroller or class and you can call that funcion form anywhere
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sayHi(notificatino:)), name: NSNotification.Name("test"), object: nil)

        // Do any additional setup after loading the view.
    }
    @objc func sayHi(notificatino:Notification){
        print("Hi")
    }
}

