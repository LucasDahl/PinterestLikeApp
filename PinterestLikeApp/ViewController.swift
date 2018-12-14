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
    let viewModel = ViewModel(client: UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        // Insets
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // Init viewMondel
        viewModel.showLoading = {
            
            if self.viewModel.isLoading {
                
                // Start the animation for the activity indicator
                self.activityIndicator.stopAnimating()
                
                // Hide the collectionView
                self.collectionView.alpha = 0
                
            } else {
                
                // Stop the animation for the activity indicator
                self.activityIndicator.stopAnimating()
                
                // Unhide the collectionView
                self.collectionView.alpha = 1
                
            }
            
        }
        
        // ViewModel error
        viewModel.showError = { error in
            
            print(error)
            
        }
        
        // Reload the collectionView
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        
        // Fetch the photos
        viewModel.fetchPhotos()
        
        
    }// End viewDidLoad


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
        let image = viewModel.cellViewModels[indexPath.row].image
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
        return viewModel.cellViewModels.count
        
    }
    
    // Make the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        // Get the image for the cell
        let image = viewModel.cellViewModels[indexPath.row].image
        
        // Set the cell's image
        cell.imageView.image = image
        
        // Return the cell
        return cell
        
    }
    
}

