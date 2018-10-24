//
//  ViewController.swift
//  SpeechGame
//
//  Created by Akash Soni on 24/10/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "Hello world")
    
    @IBAction func sayButton(_ sender: UIButton) {
        myUtterance = AVSpeechUtterance(string: textView.text)
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }

}

