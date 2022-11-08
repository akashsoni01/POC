//
//  DataTaskHandler.swift
//  Movie ticket booking app
//
//  Created by Akash soni on 08/11/22.
//

import Foundation

struct Constants {
    typealias movieListComplition = (_ :MovieData?) -> Void
    typealias ratingComplition = (_ :Ratings?) -> Void
    static let baseURL = "https://api.npoint.io/"
}

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


/*
// how to use
    private func fetchRatings() {
        APIs.fetchRatings(urlString: Constants.baseURL + "3f07f86370e2f122234c") { ratings in
            for i in 0 ..< self.movieList.count {
                guard let ratings = ratings else { return }
                let rating = ratings.filter({ rating in
                    return self.movieList[i].id == rating.id
                }).first?.rating ?? 0.0
                self.movieList[i].rating = String(format: "Rating: %.2f", rating)
                self.movieList[i].ratingDouble = rating
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }



*/

