//
//  UnsplashClient.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

class UnsplashClient: APIClient {
    
    // Static properties
    static let baseUrl = "https://api.unsplash.com"
    static let apiKey = ""
    
    func fetch(with endpoint: UnsplashEndpoint, completion: @escaping (Either<Photos>) -> Void) {
        
        let request = endpoint.request
        get(with: request, completion: completion)
        
    }
    
}
