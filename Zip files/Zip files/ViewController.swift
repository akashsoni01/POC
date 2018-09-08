//
//  ViewController.swift
//  Zip files
//
//  Created by Akash Soni on 06/09/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
import SSZipArchive
import AVFoundation
import AVKit

class ViewController: UIViewController,AVAssetDownloadDelegate{
    
    @IBOutlet weak var avplayerView: UIView!
    let urlStirng = "https://www.quirksmode.org/html5/videos/big_buck_bunny.mp4"
    var zipVdoUrl:String?
    lazy var session : URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = false
        let session = URLSession(configuration: config,
                                 delegate: self,
                                 delegateQueue: .main)
        return session
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callApi(){
        let url = URL(string: urlStirng)
        let req = URLRequest(url:url!)
        let task = self.session.downloadTask(with: req)
        task.resume()
    }
    

    @IBAction func downloadButton(_ sender: UIButton) {
        callApi()
    }
    
    @IBAction func playButton(_ sender: UIButton) {

    }
    
 
}






extension ViewController:URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten writ: Int64,
                    totalBytesExpectedToWrite exp: Int64) {
        print("downloaded \(100*writ/exp)%")
    }
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        print("completed: error: \(error)")
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo fileURL: URL) {
        let response = downloadTask.response
        let filemanager = FileManager.default
        let searchPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = searchPath[0] + "/"
        let url =  URL(fileURLWithPath: documentDirectory.appending((response?.suggestedFilename)!))
        let zipFolderPath = URL(fileURLWithPath: documentDirectory).appendingPathComponent("ZipFolder")
        print(zipFolderPath)
        
        if !FileManager.default.fileExists(atPath: zipFolderPath.path){
            do {
                try filemanager.createDirectory(atPath: zipFolderPath.path, withIntermediateDirectories: true, attributes: [FileAttributeKey.posixPermissions:0o777])
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        //for moving a file
        do {
            zipVdoUrl = tempZipPath(fileName: "file")
            let destinatioLocation =  URL(fileURLWithPath: zipFolderPath.path ).appendingPathComponent(url.lastPathComponent)
            print("file moving to downloads folder in documents")
            let op = SSZipArchive.createZipFile(atPath: zipVdoUrl!, withContentsOfDirectory: fileURL.path)
            print(op)

        }
        catch let err{
            print(err.localizedDescription)
        }
        
        //getting content info in a folder
        do{
            let arr = try filemanager.contentsOfDirectory(atPath: zipVdoUrl!)
         //   let arr2 = try filemanager.contentsOfDirectory(atPath: fileURL.path)
            print(arr)
          //  print(arr2)

        }catch let err{
            print(err.localizedDescription)
        }
          //  SSZipArchive.createZipFile(atPath: , withContentsOfDirectory: )
    }
    
    
}


extension ViewController{
    
    func tempZipPath(fileName:String) -> String {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path += "/\(fileName).zip"
        return path
    }
}














