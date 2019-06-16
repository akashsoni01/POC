//
//  ViewController.swift
//  Javascript manuplation ln swift webview
//
//  Created by Akash Soni on 16/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    let javaScript = "document.getElementsByClassName('gNO89b')[0].value;"
    override func viewDidLoad() {
        super.viewDidLoad()
        //just get the javascript code for acces the result string and run by this code.
        webView.delegate = self
        webView.loadRequest(URLRequest(url: URL(string: "https://www.google.com/")!))
        // Do any additional setup after loading the view.
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let resultString = webView.stringByEvaluatingJavaScript(from: javaScript){
            print("Successfully found search button value ........... ")
            print(resultString)
        }else{
            print("Did't found result")
        }
    }
}

