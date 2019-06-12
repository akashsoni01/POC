//
//  SecondViewController.swift
//  NotificationCenter in swift
//
//  Created by Akash Soni on 12/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sayhi2(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("test"), object: nil, userInfo: ["hi":"yes"])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
