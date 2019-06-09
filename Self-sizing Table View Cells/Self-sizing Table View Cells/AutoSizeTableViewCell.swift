//
//  AutoSizeTableViewCell.swift
//  Self-sizing Table View Cells
//
//  Created by Akash Soni on 09/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class AutoSizeTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
