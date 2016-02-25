//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Roman Wendelboe on 2/17/16.
//  Copyright © 2016 Roman Wendelboe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var tempImage : UIImage!
    var tempPicDiscription = ""
    var collectionData = [FlickrClass]()
    var collectImages = [UIImage]()

    override func viewDidLoad() {
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        FlickrManager.search(searchText) {
            (searchedPhotos) in
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionData = searchedPhotos
                self.collectionView.reloadData()
                print(self.collectionData.count)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.flickrClass = collectionData[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        detailVC.picText = collectionData[indexPath.row].title
        detailVC.flickrClass = collectionData[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

