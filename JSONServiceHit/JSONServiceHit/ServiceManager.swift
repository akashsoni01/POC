//
//  ServiceManager.swift
//  JSONServiceHit
//
//  Created by Akash Soni on 08/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import Foundation
class ServiceManager{
    static var users:Users?
    static func callApi() -> Users?{
    let urlString = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                self.users = try? jsonDecoder.decode(Users.self, from: data)
                }
        }
        task.resume()
        return users
    }
}
