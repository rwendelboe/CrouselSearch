//
//  CollectionViewCell.swift
//  FlickrSearch
//
//  Created by Roman Wendelboe on 2/17/16.
//  Copyright © 2016 Roman Wendelboe. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var searchedPhotos: UIImageView!
    
    var flickrClass: FlickrClass!{
        didSet{
            let url = NSURL(string: flickrClass.photoURL(false))
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data, response, error) in
                if error != nil {
                    return
                }
                
                if let imageData = UIImage( data: data!){
                    dispatch_async(dispatch_get_main_queue()){
                        self.searchedPhotos.image = imageData
                    }
                }
            }
            task.resume()
        }
    }
}
