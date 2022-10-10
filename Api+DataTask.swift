public struct Constants{   
    typealias serviceCompletion = (_ data:Data?,_ response: URLResponse?,_ err: Error?) -> Void
      static var baseUrl: String { ............    }

  
  
}

/*
    func getStudensListsAPI(isPage:Int, handler: @escaping Constants.serviceCompletion){
        let url = "\(Constants.baseUrl)/get-students/\(Constants.activeUser?.userID ?? 0)/\(isPage)"
        let request = DataTaskHandler()
        request.handler = handler
        request.fetchAsyncData(urlPath: url, dataToServer: Data(), params: [:], method: "GET")
    }


    func exapmle3PostAPI(updateProfileRequestBody:UpdateProfileResponseRequest,_ handler:@escaping Constants.serviceCompletion){
        let request = DataTaskHandler()
        request.handler = handler
        guard let data = try? JSONEncoder().encode(updateProfileRequestBody) else  { return }
        request.fetchAsyncData(urlPath: "\(Constants.baseUrl)/update-profile", dataToServer:data, params: [:], method: "POST")
    }

*/


import Foundation

class DataTaskHandler {
    var handler : Constants.serviceCompletion?
    var urlpath:URL?
    var request:URLRequest?
    
    func fetchAsyncData(urlPath : String, dataToServer : Data, params:Dictionary<String, Any> , method: String = "GET", isPublic:Bool = false,header:[String:String] = StringDictionary())
    {
        var headerDict = header
        request = URLRequest(url: URL(string: urlPath)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
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
                urlpath =  urlComp.url
                request?.url = urlpath
            }
        case "POST", "PUT":
            request?.httpBody = dataToServer
        default:
            break
        }
        
        request?.allHTTPHeaderFields = headerDict
        
        debugPrint("URL \(urlPath)")
        debugPrint("Token \(Constants.token)")
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
                self.handler?(data, response, error)
            }
            if let debugData = data{
                debugPrint("Response Body \(debugData.prettyJson ?? "No Body")")
            }
        }
        task.resume()
    }
    
}

extension DataTaskHandler
{
    func fetchAsyncFormData(urlPath : String, dataToServer : Data, params:Dictionary<String, Any> , method: String = "GET", isPublic:Bool = false,header:[String:String] = StringDictionary()){
        var headerDict = header
        request = URLRequest(url: URL(string: urlPath)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request?.httpMethod = method
        if !isPublic{
            headerDict["TOKEN"] = Constants.token
            headerDict["OS"] = "ios"

        }
        headerDict["PACKAGE"] = Constants.packageName

        let boundary = "Boundary-\(UUID().uuidString)"
        
        request?.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
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
                urlpath =  urlComp.url
                request?.url = urlpath
            }
        case "POST", "PUT":
            request?.httpBody = createBodyWithParameters(param: params as? [String : String], boundary: boundary)
        default:
            break
        }
        debugPrint("URL \(urlPath)")
        debugPrint("Token \(Constants.token)")
        debugPrint("Headers \(request?.allHTTPHeaderFields?.description ?? "No Header")")
        debugPrint("Params Request Body: \(params)")
        request?.allHTTPHeaderFields = headerDict
        let configuration = URLSessionConfiguration.default
        let task = URLSession(configuration: configuration).dataTask(with: request!) {  (data, response, error) in
            DispatchQueue.main.async {
                self.handler?(data, response, error)
            }
            if let debugData = data{
                debugPrint("Response Body \(debugData.prettyJson ?? "No Body")")
            }

        }
        task.resume()
        
    }
    
    
    func createBodyWithParameters(param:[String:String]?, boundary: String) -> Data {
        var body = Data()
        
        if(param != nil) {
            for (key,value) in param! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
}
extension DataTaskHandler{
    
    func fetchAsyncUrlEncodedDataFormUrl(urlPath : String, queryParams : Dictionary<String, String> , headerParams:Dictionary<String, Any> , method: String = "GET", isPublic:Bool = false,header:[String:String] = StringDictionary()){
        var headerDict = header
        request = URLRequest(url: URL(string: urlPath)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request?.httpMethod = method
        if !isPublic{
            headerDict["TOKEN"] = Constants.token
            headerDict["OS"] = "ios"
        }
        headerDict["PACKAGE"] = Constants.packageName

        
        switch method {
        case "GET":
            if !headerParams.isEmpty {
                var urlComp = URLComponents(string: urlPath)!
                var items = [URLQueryItem]()
                
                for (key,value) in headerParams {
                    items.append(URLQueryItem(name: key, value: value as? String))
                }
                
                items = items.filter{!$0.name.isEmpty}
                
                if !items.isEmpty {
                    urlComp.queryItems = items
                }
                urlpath =  urlComp.url
                request?.url = urlpath
            }
        case "POST", "PUT":
            request?.httpMethod = "POST";
            request?.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request?.httpBody = createFormUrlEncodedData(params: queryParams)
        default:
            break
        }
        
        request?.allHTTPHeaderFields = headerDict
        
        debugPrint("URL \(urlPath)")
        debugPrint("Token \(Constants.token)")
        debugPrint("Headers \(request?.allHTTPHeaderFields?.description ?? "No Header")")
        if let debugData = request?.httpBody{
            debugPrint("Request Body \(debugData.prettyJson ?? "No Body")")
        }
        
        let configuration = URLSessionConfiguration.default
        let task = URLSession(configuration: configuration).dataTask(with: request!) {  (data, response, error) in
            DispatchQueue.main.async {
                self.handler?(data, response, error)
            }
            if let debugData = data{
                debugPrint("Response Body \(debugData.prettyJson ?? "No Body")")
            }
        }
        task.resume()
        
    }
    
    func createFormUrlEncodedData(params:[String:String]) -> Data{
        var requestComponent = URLComponents()
        var data = [URLQueryItem]()
        for (key,value) in params{
            data.append(URLQueryItem(name: key, value: value))
        }
        requestComponent.queryItems = data
        return requestComponent.query?.data(using: .utf8) ?? Data()
    }
}
