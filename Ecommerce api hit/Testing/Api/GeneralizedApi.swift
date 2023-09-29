//
//  GenericApi.swift
//  Testing
//
//  Created by Akash soni on 29/09/23.
//

// take reference for other type of apis https://github.com/akashsoni01/POC/blob/master/Api%2BDataTask.swift

import Foundation

struct GeneralizedApi {
    typealias ServiceCompletion = (_ data:Data?,_ response: URLResponse?,_ err: Error?) -> Void
    typealias StringDictionary = [String: String]
    
    static func fetchAsyncData(
        urlPath: String,
        dataToServer: Data = Data(), params:Dictionary<String, Any> = [:],
        method: String = "GET",
        isPublic:Bool = false,
        header:[String:String] = StringDictionary(),
        handler : ServiceCompletion?
    ) {
        let headerDict = header
        var request: URLRequest? = URLRequest(url: URL(string: urlPath)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request?.httpMethod = method
//         if !isPublic{
//             headerDict["TOKEN"] = Constants.token
//             headerDict["OS"] = "ios"

//         }
//         headerDict["PACKAGE"] = Constants.packageName
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch method {
        case "GET":
            if !params.isEmpty {
                var urlComp = URLComponents(string: urlPath)!
                var items = [URLQueryItem]()
                
                for (key,value) in params {
                    items.append(URLQueryItem(name: key, value: value as? String))
                }
                
                items = items.filter{!$0.name.isEmpty}
                
                if !items.isEmpty {
                    urlComp.queryItems = items
                }
                guard let url = URL(string: urlPath) else { return }
                request?.url = url
            }
        case "POST", "PUT":
            request?.httpBody = dataToServer
        default:
            break
        }
        
        request?.allHTTPHeaderFields = headerDict
        
        debugPrint("URL \(urlPath)")
//        debugPrint("Token \(Constants.token)")
        debugPrint("Headers \(request?.allHTTPHeaderFields?.description ?? "No Header")")
        if let debugData = request?.httpBody{
            debugPrint("Request Body \(debugData.prettyJson ?? "No Body")")
        }
        let configuration = URLSessionConfiguration.default
        let task = URLSession(configuration: configuration).dataTask(with: request!) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode,"<--------CODE")
                }
          
            DispatchQueue.main.async {
                handler?(data, response, error)
            }
            if let debugData = data{
                debugPrint("Response Body \(debugData.prettyJson ?? "No Body")")
            }
        }
        task.resume()
    }
    
}


extension Data {
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
        
        return prettyPrintedString
    }
}

