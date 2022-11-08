//
//  DataTaskHandler.swift
//  Movie ticket booking app
//
//  Created by Akash soni on 08/11/22.
//

import Foundation

class APIs {
    static func fetchApi(urlString: String, handler: @escaping Constants.movieListComplition) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) { data, response, error in
            
            if error == nil {
                guard let data = data else { return }
                let model = try? JSONDecoder().decode(MovieData.self, from: data)
                handler(model)
            }
        
        }.resume()
    }
    
    static func fetchRatings(urlString: String, handler: @escaping Constants.ratingComplition) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) { data, response, error in

            if error == nil {
                guard let data = data else { return }
                let model = try? JSONDecoder().decode(Ratings.self, from: data)
                handler(model)
            }

        }.resume()
    }

}
