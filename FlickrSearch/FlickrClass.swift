//
//  FlickrClass.swift
//  FlickrSearch
//
//  Created by Roman Wendelboe on 2/17/16.
//  Copyright © 2016 Roman Wendelboe. All rights reserved.
//

import Foundation

class FlickrClass{
    var id = ""
    var owner = ""
    var secret = ""
    var server = ""
    var farm = ""
    var title = ""
    
    func photoURL(detail: Bool) ->String{
        if detail == true {
                return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_c.jpg"
        }else{
            return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        }
    }
    
    init(itemJSON: [String: AnyObject]){
        
        guard let title = itemJSON["title"] as? String
            else{
                return
        }
        self.title = title
        
        guard let id = itemJSON["id"] as? String
            else{
                return
        }
        self.id = id
        
        guard let owner = itemJSON["owner"] as? String
            else{
                return
        }
        self.owner = owner
        
        guard let secret = itemJSON["secret"] as? String
            else{
                return
        }
        self.secret = secret
        
        guard let server = itemJSON["server"] as? String
            else{
                return
        }
        self.server = server
        
        guard let farm = itemJSON["farm"] as? Int
            else{
                return
        }
        self.farm = farm.description
    }
}



