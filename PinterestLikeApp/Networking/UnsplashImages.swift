//
//  UnsplashImages.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

//NOTE: API with a dictionary need to have a class or struct

import Foundation

// Create a typeAlias
typealias Photos = [Photo]

struct Photo: Codable {
    
    let id:String
    let urls: URLS
    
}

struct URLS: Codable {
    
    // Properties to call the API
    let raw:URL
    let full:URL
    let regular:URL
    let small:URL
    let thumb:URL
    
}
