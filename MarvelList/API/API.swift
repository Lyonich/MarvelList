//
//  API.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 20.07.2021.
//

import Foundation

final class APIClient {
    
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        
        bodyTaskRequest(request, result: result)
    }
    
    func loadImage(URL: URL, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(url: URL)
        
        bodyTaskRequest(request, result: result)
    }
    
    // MARK: - Private
    
    private func bodyTaskRequest(_ request: URLRequest, result: @escaping ((Result<Data>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let error = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        
        task.resume()
    }
    
}




