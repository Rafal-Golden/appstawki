//
//  NetworkService.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import UIKit


protocol NetworkServiceProtocol {
    func getAppetizers(completion: @escaping (Result<[AppetizerModel], AppError>) -> Void)
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)
    
    func getAppetizersAsync() async throws -> [AppetizerModel]
}

final class NetworkService: NetworkServiceProtocol {
    
    let urlSession: URLSessionProtocol
    let queue: AppQueueProtocol
    let cache: ImageCacheProtocol
    let config: ServiceConfigProtocol
    
    init(urlSession: URLSessionProtocol, queue: AppQueueProtocol, cache: ImageCacheProtocol, config: ServiceConfigProtocol) {
        self.urlSession = urlSession
        self.queue = queue
        self.cache = cache
        self.config = config
    }
    
    private func getAppetizersBG(completion: @escaping (Result<[AppetizerModel], AppError>) -> Void) {
        guard let requestURL = config.pathURL(endpoint: "appetizers") else {
            completion(.failure(.undefinedURL))
            return
        }
        let request = URLRequest(url: requestURL)
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.unableToComplete))
                return
            }
            
            guard let data else { completion(.failure(.invalidData)); return }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            do {
                let appetizerResponse = try decoder.decode(AppetizerResponse.self, from: data)
                let appetizers = appetizerResponse.request
                completion(.success(appetizers))
            } catch let error {
                completion(.failure(.parsingFailed(error)))
            }
        }
        task.resume()
    }
    
    private func downloadImageBG(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = url.absoluteString
        
        if let image = cache.getImage(forKey: cacheKey) {
            completion(image)
            return
        }
        
        let task = urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
            if let data, let image = UIImage(data: data) {
                self?.cache.setImage(image, forKey: cacheKey)
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // MARK: - public -
    
    func getAppetizers(completion: @escaping (Result<[AppetizerModel], AppError>) -> Void) {
        getAppetizersBG { result in
            self.queue.onMainAsync {
                completion(result)
            }
        }
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        downloadImageBG(url: url) { image in
            self.queue.onMainAsync {
                completion(image)
            }
        }
    }
    
    func getAppetizersAsync() async throws -> [AppetizerModel] {
        guard let requestURL = config.pathURL(endpoint: "appetizers") else {
            throw AppError.undefinedURL
        }
        
        let (data, response) = try await urlSession.data(from: requestURL, delegate: nil)
 
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AppError.unableToComplete
        }
            
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let appetizerResponse = try decoder.decode(AppetizerResponse.self, from: data)
            return appetizerResponse.request
        } catch let error {
            throw AppError.parsingFailed(error)
        }
    }
}
