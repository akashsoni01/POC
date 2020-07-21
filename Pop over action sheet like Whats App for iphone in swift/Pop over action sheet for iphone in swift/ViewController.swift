//
//  ViewController.swift
//  Pop over action sheet for iphone in swift
//
//  Created by AkashBuzzyears on 6/23/20.
//  Copyright © 2020 akash soni. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapped(_ sender:UIButton){
        FTConfiguration.shared
        FTPopOverMenu.showForSender(sender: sender,
                                    with: ["Share","delete"],
                                    done: { (selectedIndex) -> () in
                              
                                        print(selectedIndex)
        }) {
            
        }

    }

}

