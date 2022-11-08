//
//  ImageCache.swift
//  Movie ticket booking app
//
//  Created by Akash soni on 08/11/22.
//

import UIKit

struct Constants {
        static var imageCache = NSCache<AnyObject, AnyObject>()
}

extension UIImageView {
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        image = nil

        if let imageFromCache = Constants.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let imageData = data else { return }
                Constants.imageCache.setObject(data as AnyObject, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    if error != nil {
                        self.image = nil
                    } else {
                        self.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }


    }
}

