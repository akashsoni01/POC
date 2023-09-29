//
//  Apis.swift
//  Testing
//
//  Created by Akash soni on 29/09/23.
//

import Foundation

struct Apis {
    static let baseURL = "https://dummyjson.com" // Apis.Constants.baseURL

    struct Endpoints {
        // Apis.Constants.Endpoints.products
        static let products = "/products"
        static let detail = "/detail"
    }

    // for more generalization of api use
    // typealias serviceCompletion = (_ data:Data?,_ response: URLResponse?,_ err: Error?) -> Void
    
    typealias ProductsComplition = (_ products: [Product],_ err: Error?) -> Void
    
    
    // Call using url session in non general approach
    // we have to write initial setup code each time, the code is also not flexible for other type of 
    static func callProductsApi(complition: @escaping ProductsComplition) {
        
        guard let url = URL(string: baseURL + Endpoints.products) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                complition([], error)
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let data = data else { return }
                let base = try? JSONDecoder().decode(BaseModel.self, from: data)
                complition(base?.products ?? [], nil)
            }
        }.resume()

    }
    
    
    // call using seprate handler and more generic approach
    static func callProducts(complition: @escaping ProductsComplition) {
        GeneralizedApi.fetchAsyncData(urlPath: baseURL + Endpoints.products) { data, response, err in
            guard let data = data else { return }
            let base = try? JSONDecoder().decode(BaseModel.self, from: data)
            complition(base?.products ?? [], nil)
        }
    }
    
    
    // call api that depends on each other
    // this is one way of calling dependent apis
    static func callMultipleApis(complition: @escaping ProductsComplition) {
        callProducts { products1, err in
            callProductsApi { products2, err in
                complition(products1 + products2, err)
            }
        }
    }
    
    
    // call api
}
