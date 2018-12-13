//
//  Endpoint.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

// The protocol for the endpoint
protocol Endpoint {
    var baseUrl:String { get }
    var path:String { get }
    var urlParameters:[URLQueryItem] { get }
}

// This creates the full url
extension Endpoint {
    var urlComponent: URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        return urlComponent!
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
    
}

// Enums for case for order sorting
enum Order:String {
    case popular, latest, oldest
}

// Get the data from the API
enum UnsplashEndpoint: Endpoint {
    case photos(id:String, order: Order)
    
    var baseUrl:String {
        return "https://api.unsplash.com"
    }
    
    // Create a path for photos
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        switch self {
        case .photos(let id, let order):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "order_by", value: order.rawValue)
            ]
        }
    }
}
