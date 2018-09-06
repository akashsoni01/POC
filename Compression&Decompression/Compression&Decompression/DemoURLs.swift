//
//  DemoURLs.swift
//  Compression&Decompression
//
//  Created by Akash Soni on 06/09/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import Foundation

struct DemoURLs{
    static let urlStrings:[Int:String] = [1:"http://www.gstatic.com/webp/gallery/2.jpg",2:"https://images.freeimages.com/images/large-previews/335/vale-da-lua-2-1401161.jpg",3:"http://www.imagemagick.org/image/wizard.png"]
    
    
    static func imageNamed(name:Int)->URL?{
        if let urlString = urlStrings[name]{
            return URL(string: urlString)
        }
        return nil
    }
}
