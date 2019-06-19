//
//  ViewController.swift
//  Bullet strings in swift ios
//
//  Created by Akash Soni on 19/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label:UILabel!
    var data = ["akash soni","akash soni","akash soni","akash soni","akash soni"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedText = add(bulletList: data, font: UIFont(name: "Helvetica Neue", size: 14)!)
        label.attributedText = attributedText
        // Do any additional setup after loading the view.
    }

    func add(bulletList strings: [String],
             font: UIFont,
             indentation: CGFloat = 15,
             lineSpacing: CGFloat = 3,
             paragraphSpacing: CGFloat = 10,
             textColor: UIColor = .black,
             bulletColor: UIColor = .red) -> NSAttributedString {
        
        func createParagraphAttirbute() -> NSParagraphStyle {
            var paragraphStyle: NSMutableParagraphStyle
            let nonOptions = NSDictionary() as! [NSTextTab.OptionKey: Any]
            
            paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.tabStops = [
                NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
            paragraphStyle.defaultTabInterval = indentation
            paragraphStyle.firstLineHeadIndent = 0
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.paragraphSpacing = paragraphSpacing
            paragraphStyle.headIndent = indentation
            return paragraphStyle
        }
        
        let bulletPoint = "\u{2022}"
        let textAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: bulletColor]
        let buffer = NSMutableAttributedString.init()
        
        for string in strings {
            let formattedString = "\(bulletPoint)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            let paragraphStyle = createParagraphAttirbute()
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bulletPoint)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            buffer.append(attributedString)
        }
        
        return buffer
    }
}

