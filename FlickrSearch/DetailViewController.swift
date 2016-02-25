//
//  DetailViewController.swift
//  FlickrSearch
//
//  Created by Roman Wendelboe on 2/18/16.
//  Copyright © 2016 Roman Wendelboe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var flickr: FlickrClass!
    
    var picText = ""
    var choosenImage : UIImage!
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        detailLabel.text = picText
        detailImageView.image = choosenImage
    }
    
    var flickrClass: FlickrClass!{
        didSet{
            let url = NSURL(string: flickrClass.photoURL(true))
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data, response, error) in
                if error != nil {
                    return
                }
                
                if let imageData = UIImage( data: data!){
                    dispatch_async(dispatch_get_main_queue()){

                        self.detailImageView.image = imageData
                    }
                }
            }
            task.resume()
        }
    }
}
