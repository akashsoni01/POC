//
//  ViewController.swift
//  Load Html on webview using tableview in swift
//
//  Created by AkashBuzzyears on 6/30/20.
//  Copyright © 2020 akash soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate {
    @IBOutlet weak var tableview:UITableView!
    var contentHeights : [CGFloat] = [0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0, 0.0]
    
    let htmlData = ["hello world",
        "<html><body><p>Hello  hello <br> hello</p> </body></html>","<html><body><p>Hello!</p></body></html>","<html><body><p>Hello!</p></body></html>","<html><body><p>Hello!</p></body></html>",
        """
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style> body { font-size: 150%; } </style>
    </head>
    <body>
    hello test lsadkjflaksdjf as dlkfjas df.
    </body>
    </html>
    """,
        """
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style> body { font-size: 150%; } </style>
    </head>
    <body>
    hello test lsadkjflaksdjf as dlkfjas df.
    </body>
    </html>
    """,
        """
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style> body { font-size: 150%; } </style>
    </head>
    <body>
    hello test lsadkjflaksdjf as dlkfjas df.
    hello test lsadkjflaksdjf as dlkfjas df.
    hello test lsadkjflaksdjf as dlkfjas df.
    </body>
    </html>
    """
    ,"<html><body><p>Hello!</p></body></html>"
        ,"<html><body><p>Hello!</p></body></html>","""
                <html>
                <head>
                <style>
                ul {
                list-style: none;
                }

                ul li::before {
                content: "\\2022";
                color: red;
                font-weight: bold;
                display: inline-block;
                width: 1em;
                margin-left: -1em;
                }
                </style>
                </head>
                <body>

                <h2>Change Bullet Color of List Items</h2>

                <ul>
                <li>Adele</li>
                <li>Agnes</li>
                <li>Billy</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                <li>Bob</li>
                </ul>

                </body>
                </html>
        ""","""
<html><body><h1>This is the title</h1><p>This is the first paragraph.</p><img src="https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png" width=\"360\" height=\"240\"><p>This is the second paragraph.</p><p>This is the third paragraph.</p><p>This is the fourth paragraph.</p><p>This is the last paragraph.</p></body></html>
"""]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.estimatedRowHeight = 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return htmlData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebViewTableViewCell") as! WebViewTableViewCell
        self.adjustUITextViewHeight(arg: cell.textview)
        cell.textview.attributedText = htmlData[indexPath.row].htmlToAttributedString
//        cell.label.text = htmlData[indexPath.row]
        
//        cell.webview.tag = indexPath.row
//        cell.webview.delegate = self
//        cell.webview.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: htmlHeight)
//        cell.webview.loadHTMLString(htmlData[indexPath.row], baseURL: nil)
        
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//                if (contentHeights[webView.tag] != 0.0)
//        {
//            // we already know height, no need to reload cell
//            return
//        }
//
//        contentHeights[webView.tag] = webView.scrollView.contentSize.height + 100 // cell ki height
//        tableview.reloadRows(at: [IndexPath(row: webView.tag, section: 0)], with: .automatic)
//
//    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }


}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

