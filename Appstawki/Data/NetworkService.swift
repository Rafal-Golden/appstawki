//
//  NetworkService.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import UIKit

protocol NetworkServiceProtocol {
    func getAppetizers(completion: @escaping (Result<[AppetizerModel], NetworkService.AppError>) -> Void)
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    let urlSession: URLSession
    let cache = NSCache<NSString, UIImage>()
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    enum AppError: Error {
        case undefinedURL
        case unableToComplete
        case invalidData
        case parsingFailed(Error)
    }
    
    private let baseURL = URL(string: "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/")
    
    private func getAppetizersBG(completion: @escaping (Result<[AppetizerModel], AppError>) -> Void) {
        guard let requestURL = baseURL?.appending(component: "appetizers") else {
            completion(.failure(.undefinedURL))
            return
        }
        let request = URLRequest(url: requestURL)
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
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
        
        let cacheKey = NSString(string: url.absoluteString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
            if let data, let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: cacheKey)
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
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        downloadImageBG(url: url) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
}

extension NetworkService {
    convenience init() {
        self.init(urlSession: URLSession(configuration: .default))
    }
}
