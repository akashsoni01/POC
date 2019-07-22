//
//  ViewController.swift
//  Open app setting on button tap in swift 4.2
//
//  Created by Akash Soni on 22/07/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (isSuccesfulOpened) in
                print("Succesful :\(isSuccesfulOpened)")
            }
        }
    }
    
}

