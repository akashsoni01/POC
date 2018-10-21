//
//  ViewController.swift
//  SearchViewController
//
//  Created by Akash Soni on 21/10/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
class MySearchController : UISearchController {
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var searcher : UISearchController!
    let cellID = "Cell"
    @IBOutlet weak var tableView: UITableView!
    let data = ["akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","akash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash","vikash"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.sectionIndexColor = .white
        self.tableView.sectionIndexBackgroundColor = .red
        let src = SearchResultsController(data: data)
        let searcher = MySearchController(searchResultsController: src)
        self.searcher = searcher
        searcher.searchResultsUpdater = src
        let b = searcher.searchBar
        b.sizeToFit() // crucial, trust me on this one
        b.autocapitalizationType = .none
        self.tableView.tableHeaderView = b
        src.searchBar = b // *
        self.tableView.reloadData()
        self.tableView.scrollToRow(at:
            IndexPath(row: 0, section: 0),
                                   at:.top, animated:false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return indexPath.row/2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    /////////////////////////////////
    override var prefersStatusBarHidden : Bool {
        return true
    }

}

