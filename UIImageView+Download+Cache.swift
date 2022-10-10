struct Constants {
    static let imageCache = NSCache<AnyObject, AnyObject>()
}


extension UIImageView{
    
    func downloadImage(urlString: String){
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        {
            image = nil
            
            if let imageFromCache = Constants.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            //imageView.startShimmering()
            URLSession.shared.dataTask(with: url) {
                [weak self]
                data, response, error  in
                if error != nil
                {
                    DispatchQueue.main.async {
                        //imageView.stopShimmering()
                        self?.image = nil
                    }
                }
                if let _ = data {
                    DispatchQueue.main.async {
                        guard let imageToCache = UIImage(data: data!) else { return }
                        var compressionPercentage = 1.0
                        //if data is greater then 1mb then compress it and decrease size to 1 mb
                        if (data?.count ?? 0) > 524288{
                            compressionPercentage = 524288.0 / Double(data?.count ?? 1)
                        }
                        let compressedData = imageToCache.jpegData(compressionQuality: CGFloat(compressionPercentage))
                        guard let compressedimageToCache = UIImage(data: compressedData!) else { return }
                        Constants.imageCache.setObject(compressedimageToCache, forKey: urlString as AnyObject)
                        self?.image = compressedimageToCache
                        //imageView.stopShimmering()
                    }
                }
            }.resume()
        }
        
    }
    
}
