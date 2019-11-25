//
//  PDFViewController.swift
//  PDFView_in_swift
//
//  Created by Akash Soni on 07/11/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    var pdfView = PDFView()
    var pdfURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.minScaleFactor = 0.1
        pdfView.maxScaleFactor = 5

        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        self.downloadPDF()
    }
    func showPDF(){
        view.addSubview(pdfView)
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func downloadPDF(){
        
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
}
extension PDFViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
            DispatchQueue.main.async {
                self.showPDF()
            }
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}


/*
 write code in view controller
 
 
 class ViewController: UIViewController {
 
 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the view.
 }
 @IBAction func buttonTapped(_ sender: UIButton) {
 let pdfViewController = PDFViewController()
 self.navigationController?.pushViewController(pdfViewController, animated: true)
 }
 
 }
 
 
 */
