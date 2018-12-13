//
//  ViewModel.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

// Strucct for CellViewMOdel
struct CellViewModel {
    let image: UIImage
}

class ViewModel {
    
    //=================
    // MARK: Properties
    //=================
    
    private let client: APIClient // Make the API client
    private var photos: Photos = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    var cellViewModels: [CellViewModel] = []
    
    //=========
    // Mark: UI
    //=========
    
    var isLoading = false {
        didSet {
            showLoading?()
        }
    }
    
    // Closures to notfiy collectionView
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    // Init the client
    init(client: APIClient) {
        self.client = client
    }
    
    // Fetch the photos
    func fetchPhotos() {
        
        if let client = client as? UnsplashClient {
            
            // Loading is happening
            self.isLoading = true
            
            // GEt the endpoint
            let endpoint = UnsplashEndpoint.photos(id: UnsplashClient.apiKey, order: .popular)
            
            // Setup the client
            client.fetch(with: endpoint) { (either) in
                
                switch either {
                case .success(let photos):
                    self.photos = photos
                case .error(let error):
                    self.showError?(error)
                    
                } // End switch
                
            }// End closure
            
        }// End optional binding
        
    } // End fetch
    
    // Get the photo
    private func fetchPhoto() {
        
        // Create the dispatch group
        let group = DispatchGroup()
        
        self.photos.forEach { (photo) in
            
            // Do th eloading on the background thread
            DispatchQueue.global(qos: .background).async(group: group) {
                
                // Enter the group
                group.enter()
                
                // Get the imageData
                guard let imageData = try? Data(contentsOf: URL(string: "")!) else {
                    
                    // Show the error
                    self.showError?(APIError.unknown)
                    
                    return
                    
                }
                
                // get the image
                guard let image = UIImage(data: imageData) else {
                    
                    // Show the error
                    self.showError?(APIError.unknown)
                    
                    return
                    
                }
                
                // Append th ephoto
                self.cellViewModels.append(CellViewModel(image: image))
                
                // Leave the group
                group.leave()
                
            }
        }
        // Notify the group since the loading is done
        group.notify(queue: .main) {
            
            // Set isLoading back to false
            self.isLoading = false
            
            // reload the data
            self.reloadData?()
        }
        
    } // End fetch photo
    
} // End class

