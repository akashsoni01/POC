//
//  ViewController.swift
//  VideoDownloadAV
//
//  Created by Akash Soni on 16/08/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,AVAssetDownloadDelegate,URLSessionTaskDelegate {
    @IBOutlet weak var view1: UIView!
    let url = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8")!
    let sessionId = "com.mycompany.background"
    let queue = OperationQueue()
    var task: AVAssetDownloadTask?
    var session: AVAssetDownloadURLSession?


    @IBAction func download() {
        
       let config =  URLSessionConfiguration.background(withIdentifier: sessionId)
        session = AVAssetDownloadURLSession(configuration: config, assetDownloadDelegate: self, delegateQueue: queue)
        let assetUrl = AVURLAsset(url: url)
        task = session?.makeAssetDownloadTask(asset: assetUrl, assetTitle: "assetTitle", assetArtworkData: nil, options: nil)
        task?.resume()
        
        DispatchQueue.main.async(){
            let playerItem = AVPlayerItem(asset: (self.task?.urlAsset)!)
            let player = AVPlayer(playerItem: playerItem)
            let palyerController = AVPlayer
            player.play()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
    

