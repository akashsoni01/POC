//
//  ViewController.swift
//  LocalizationiOS
//
//  Created by Akash Soni on 21/04/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeTitle(_ sender: Any) {
         button.setTitle(NSLocalizedString("Welcome", comment: ""), for: .normal)
    }
    
}

