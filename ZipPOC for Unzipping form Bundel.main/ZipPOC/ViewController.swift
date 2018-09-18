//
//  ViewController.swift
//  ZipPOC
//
//  Created by Akash Soni on 18/09/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unZip(_ sender: UIButton) {
        callApi()
    }
    func callApi(){
        let filePath = Bundle.main.url(forResource: "MHBE", withExtension: "zip")
        let unzipDirectory = try? Zip.quickUnzipFile(filePath!) // Unzip
        print(unzipDirectory)
        let url = URL(fileURLWithPath: "MHBE", relativeTo: FileManager.documentUrl)
      
       
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        try? FileManager.default.moveItem(at: unzipDirectory!, to: url)
        let item = try? FileManager.default.contentsOfDirectory(atPath: url.path)
        print(item)
        print("Successfully moved")
        
        
        
        
    }


}

public extension FileManager{
    static var documentUrl:URL {
        get {
            return try! FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            
        }
    }
}
