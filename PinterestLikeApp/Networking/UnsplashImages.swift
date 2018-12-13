//
//  UnsplashImages.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

// Create a typeAlias
typealias Photos = [Photo]

struct Photo: Codable {
    
    let id:String
    let urls: URLS
    
}

enum URLS: String, Codable {
    
    case raw, full, regular, small, thumb
    
}
