//
//  ViewController.swift
//  UISearchController Swift 4.2
//
//  Created by Akash Soni on 08/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController ,UISearchResultsUpdating{
    @IBOutlet weak var tableView: UITableView!
    let data = ["akash","bkash","ckash","dkash","mkash","chakas","lkash","tkash"]
    var filttredData = [String]()
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 0 {
            filttredData = data.filter{
                $0.lowercased().contains(text.lowercased())
            }
        }else{
            filttredData = self.data
        }

        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        filttredData = data
        navigationItem.title = "Search"
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        search.searchBar.showsCancelButton = true
        // Do any additional setup after loading the view.
    }


}
extension SearchViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filttredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = filttredData[indexPath.row]
        return cell!
    }
    
    
}

//https://www.hackingwithswift.com/example-code/uikit/how-to-use-uisearchcontroller-to-let-users-enter-search-words
