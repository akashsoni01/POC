//
//  RoundedButton.swift
//  SpeakGame
//
//  Created by Akash Soni on 02/01/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit
class RoundedButton: UIButton {
    
    override func layoutSubviews() {
    super.layoutSubviews()
        self.layer.cornerRadius = min(self.frame.width,self.frame.height) / 2
        self.clipsToBounds = true
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 2
        
    }

}
