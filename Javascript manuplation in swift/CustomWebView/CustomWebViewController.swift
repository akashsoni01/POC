//
//  CustomWebViewController.swift
//  CustomWebView
//
//  Created by Akash Soni on 28/05/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit
import WebKit

class CustomWebViewController: UIViewController,WKNavigationDelegate,WKScriptMessageHandler {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var backwordBtn: UIBarButtonItem!
    var url:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.navigationDelegate = self
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pangestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        if url != nil {
            let request = URLRequest(url: url!)
            wkWebView.load(request)
            wkWebView.addObserver(self, forKeyPath: "loading", options: NSKeyValueObservingOptions.new
                , context: nil)
            wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new
                , context:  nil)
            forwardBtn.isEnabled = false
            backwordBtn.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    @objc func pangestureRecognizerAction(_ gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        view.frame.origin = translation
        if gesture.state == .ended{
            let velocity = gesture.velocity(in: view)
            if velocity.y >= 1500{
                self.dismiss(animated: true, completion: nil)
            }else{
                //return to original position
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = CGPoint.zero
                }
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.containerView.layer.cornerRadius = 18
        self.urlLabel.text = wkWebView.title
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        // text to share
        let text = wkWebView.url?.absoluteString
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    //  button action
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        wkWebView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        wkWebView.goForward()
    }
    @IBAction func reload(sender: UIBarButtonItem) {
        let request = URLRequest(url: wkWebView.url!)
        wkWebView.load(request)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressBar.setProgress(0.0, animated: true)
        //        webView.evaluateJavaScript("template-notices") { (result, error) in
       //signup_submit
        
//        let javascript =
//            "var outerHTML = document.documentElement.outerHTML.toString()\n" + "var message = {\"type\": \"outerHTML\", \"outerHTML\": outerHTML }\n" + "window.webkit.messageHandlers.WebViewControllerMessageHandler.postMessage(message)\n"
        
        //working script
        
        //add your javascript code here onl
        let javascript = "document.getElementsByTagName('DIV')[0];"
//        let javascript = "document.getElementsByTagName('H2').getGetElementById('max-width-800')[0].value;"
        
        evaluateJavascript(javascript, sourceURL: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Error......")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading"{
            backwordBtn.isEnabled = wkWebView.canGoBack
            forwardBtn.isEnabled = wkWebView.canGoForward
            
        }
        if keyPath == "estimatedProgress"{
            progressBar.isHidden = wkWebView.estimatedProgress == 1
            progressBar.setProgress(Float(wkWebView.estimatedProgress), animated: true)
        }
        
    }
    
    private func evaluateJavascript(_ javascript: String, sourceURL: String? = nil, completion: ((_ error: String?) -> Void)? = nil) {
        var javascript = javascript
        
        // Adding a sourceURL comment makes the javascript source visible when debugging the simulator via Safari in Mac OS
        if let sourceURL = sourceURL {
            javascript = "//# sourceURL=\(sourceURL).js\n" + javascript
        }
        wkWebView.evaluateJavaScript(javascript) { (result, error) in
            print(result)
        }
        wkWebView.evaluateJavaScript(javascript) { _, error in
            completion?(error?.localizedDescription)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [String: Any] else {
            print("could not convert message body to dictionary: \(message.body)")
            return
        }
        
        guard let type = body["type"] as? String else {
            print("could not convert body[\"type\"] to string: \(body)")
            return
        }
        
        switch type {
        case "outerHTML":
            guard let outerHTML = body["outerHTML"] as? String else {
                print("could not convert body[\"outerHTML\"] to string: \(body)")
                return
            }
            print("outerHTML is \(outerHTML)")
        default:
            print("unknown message type \(type)")
            return
        }
    }
    
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
