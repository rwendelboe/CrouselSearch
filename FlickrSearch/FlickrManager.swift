//
//  FlickrManager.swift
//  FlickrSearch
//
//  Created by Roman Wendelboe on 2/19/16.
//  Copyright © 2016 Roman Wendelboe. All rights reserved.
//

import Foundation

class FlickrManager{
    static let flickrBaseApi = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e211c51ef36407c4cb7cdca7ce3a51b9&sort=relevance&format=json&nojsoncallback=true&text="
    
    static func search(query: String, completion: (pics: [FlickrClass]) -> Void) {

        guard let escapedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(
            .URLHostAllowedCharacterSet()),
            let url = NSURL(string: flickrBaseApi + escapedQuery)
            else {
                return
        }
        
        print(url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            
            if error != nil {
                print("Error: \(error!.code.description)")
                return
            }
            
            var json: [String: AnyObject]
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String : AnyObject]
            } catch {
                return
            }
            
            let pics = parsePhotosFrom(json)
            completion(pics: pics)
        }
        task.resume()
    }
    
    static func parsePhotosFrom(json: [String: AnyObject]) -> [FlickrClass] {
        var photos = [FlickrClass]()
        guard let jsonpics = json["photos"] as? [String: AnyObject],
            let jsonItems = jsonpics["photo"] as? [[String: AnyObject]]
            else {
                return photos
        }
        
        for jsonItem in jsonItems {
            photos.append(FlickrClass(itemJSON: jsonItem))
        }
        return photos
    }
}