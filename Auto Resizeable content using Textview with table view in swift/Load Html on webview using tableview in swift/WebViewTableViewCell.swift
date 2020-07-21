//
//  WebViewTableViewCell.swift
//  Load Html on webview using tableview in swift
//
//  Created by AkashBuzzyears on 6/30/20.
//  Copyright © 2020 akash soni. All rights reserved.
//

import UIKit

class WebViewTableViewCell: UITableViewCell {
    @IBOutlet weak var textview:UITextView!
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
