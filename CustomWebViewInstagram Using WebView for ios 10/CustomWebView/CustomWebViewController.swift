//
//  CustomWebViewController.swift
//  CustomWebView
//
//  Created by Akash Soni on 28/05/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class CustomWebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var containerView: UIView!    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var backwordBtn: UIBarButtonItem!
    var isRequested: Bool?
    var myTimer: Timer?
    var url:URL? = URL(string: "https://www.google.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backwordBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
        webView.delegate = self
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pangestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        if url != nil {
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
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
        self.urlLabel.text = url?.absoluteString
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        // text to share
        let text = webView.request?.url?.absoluteString
        
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
        webView.goBack()
    }
    
    @IBAction func goFarward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    @IBAction func reload(sender: UIBarButtonItem) {
        let request = URLRequest(url: (webView.request?.url!)!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.urlLabel.text = webView.request?.url?.absoluteString
        progressBar.progress = 0.0
        backwordBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.urlLabel.text = webView.request?.url?.absoluteString
        progressBar.setProgress(1.0, animated: true)
        backwordBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progressBar.progress = 0.0
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
