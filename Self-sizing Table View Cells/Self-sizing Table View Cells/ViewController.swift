//
//  ViewController.swift
//  Self-sizing Table View Cells
//
//  Created by Akash Soni on 09/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let arrayLong:[String] = ["akash soni is a good boy. akash soni love apple. He is a great iOS developer. One day he dreamed to work for apple. and now he is on his way.","akash soni is a good boy. akash soni love apple. He is a great iOS developer. One day he dreamed to work for apple. and now he is on his way.","akash soni is a good boy. akash soni love apple. He is a great iOS developer. One day he dreamed to work for apple. and now he is on his way.","akash soni is a good boy. akash soni love apple. He is a great iOS developer. One day he dreamed to work for apple. and now he is on his way.","and now he is on his way.","and now he is on his way.and now he is on his way.","and now he is on his way.and now he is on his way.and now he is on his way."]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AutoSizeTableViewCell
        cell.label1.text = "akash sonisonisonisonisonisonisonisonisonisonisoni"
        cell.label2.text = arrayLong[indexPath.row]
        cell.imgView.image = #imageLiteral(resourceName: "Screenshot 2019-06-04 at 12.41.38 AM")

        return cell
    }

}

