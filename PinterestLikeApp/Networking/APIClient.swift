//
//  APIClient.swift
//  PinterestLikeApp
//
//  Created by Lucas Dahl on 12/13/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

enum Either<T> {
    case success(T)
    case error(Error)
}

protocol APIClient {
    var session: URLSession { get }
    func get<T: Codable>(with request: URLRequest, completion: @escaping (Either<[T]>) -> Void)
}

extension APIClient {
    
    func get<T: Codable>(with request: URLRequest, completion: @escaping (Either<[T]>) -> Void) {
        
        // Create a data task
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Check if error has a value
            guard error == nil else {
                completion(.error(error!))
                return
            }
            
            // Check for a response
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                print("Error: with response!")
                return
            }
        
            // Decode the array of images
            guard let value = try? JSONDecoder().decode([T].self, from: data!) else {
                print("Decoder error")
                return
            }
            
            DispatchQueue.main.async {
                // Call completion success
                completion(.success(value))
            }
        
        } // End task
        
        // Resume the task
        task.resume()
        
    } // End APIClient
    
} // End extension
