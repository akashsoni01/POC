//
//  ViewController.swift
//  Testing
//
//  Created by Akash soni on 29/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callApi()
//        tableView.estimatedRowHeight = 100
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callApi), for: .valueChanged)
        
    }
    
    @objc func callApi() {
        // code for api call from a function instead of api helper
        /*
         guard let url = URL(string: "https://dummyjson.com/products") else {
             return
         }
         let urlRequest = URLRequest(url: url)
         URLSession(configuration: URLSessionConfiguration.default).dataTask(with: urlRequest) { [weak self] data, response, error in
             if error != nil {
                 // error
             } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                 guard let self = self, let data = data else { return }
                 let base = try? JSONDecoder().decode(BaseModel.self, from: data)
                 self.products = base?.products ?? []
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             }
         }.resume()
         */
        
        
// call api from apis helper
        
//        Apis.callProductsApi { [weak self] products, err in
//            guard let self = self, err == nil else { return }
//            self.products = products
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
// call api uisng generic approach
        
//        Apis.callProducts { [weak self] products, err in
//            guard let self = self, err == nil else { return }
//            self.products = products
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }

        
        // call multiple dependent api uisng generic approach
        Apis.callMultipleApis { [weak self] products, err in
            guard let self = self, err == nil else { return }
            self.products = products
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        // call multiple apis using dispatch group
        
        
    }
}


extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VCTableViewCell", for: indexPath) as? VCTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]

        cell.titleLbl.text = product.title
        cell.descLbl.text = product.description
        if let imageUrlString = product.images?.first {
            cell.imgView.downloadImage(urlString: imageUrlString)
            cell.imgView.contentMode = .scaleToFill
        }
        return cell
    }


}
