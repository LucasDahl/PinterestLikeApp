//
//  ViewController.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/12/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outelts
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Properties
    let images = [#imageLiteral(resourceName: "image-5"), #imageLiteral(resourceName: "image-7"), #imageLiteral(resourceName: "image-1"), #imageLiteral(resourceName: "image-6"), #imageLiteral(resourceName: "image-2"), #imageLiteral(resourceName: "image-4"), #imageLiteral(resourceName: "image-3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        // Insets
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }


} // End class

//==============================================================
// MARK: - Flow layout delegate (for customizing collectionView)
//==============================================================

extension ViewController: PinterestLayoutDelegate {
    
    // Would use this normally.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        // Set up the grid
////        let numberOfColumns: CGFloat = 2 // Chnage this fto change the number of columns displayed
////        let width = collectionView.frame.size.width
////        let xInsets: CGFloat = 10
////        let cellSpacing: CGFloat = 5
////        let image = images[indexPath.item]
////        let height = image.size.height
////
////        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        // Get the image height
        let image = images[indexPath.item]
        let height = image.size.height
        
        // Return height
        return height
        
    }
    
}

//====================
// MARK: - Data source
//====================

extension ViewController: UICollectionViewDataSource {
    
    
    // Number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return the number of cells
        return images.count
        
    }
    
    // Make the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        // Get the image for the cell
        let image = images[indexPath.row]
        
        // Set the cell's image
        cell.imageView.image = image
        
        // Return the cell
        return cell
        
    }
    
}

