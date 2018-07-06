//
//  ViewController.swift
//  ActivityDemo
//
//  Created by Varun Rathi on 02/08/16.
//  Copyright © 2016 NovoInvent. All rights reserved.
//

import UIKit

extension UIView
{
    @IBInspectable var cornerRadius:CGFloat=0
        {
            Get
                {
                    
            }
            Set
                {
                    
            }
    }
    
    
}


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var showActivityBtn:UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func actvityBtnClicked(sender :UIButton)
    {
    
                let string = "test object"
        let url:NSURL=NSURL(string: "https://google.com")!
        var vc=UIActivityViewController(activityItems: [string, url], applicationActivities: nil)
        
        navigationController?.presentViewController(vc, animated: true, completion: {
        print("Activty View controller called")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

