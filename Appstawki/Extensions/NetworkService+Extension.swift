//
//  URLSessionStub.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 16/10/2024.
//
import Foundation
import UIKit


extension NetworkService {
    convenience init() {
        let session = URLSession(configuration: .default)
        self.init(urlSession: session, queue: AppQueue(), cache: ImageCache(), config: ServiceConfig())
    }
}

class NetworkServiceSample: NetworkServiceProtocol {
    
    enum State {
        case loading, success, failed
    }
    private var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func getAppetizers(completion: @escaping (Result<[AppetizerModel], AppError>) -> Void) {
        switch state {
            case .loading:
                break
            case .success:
                let appetizers = MockData.appetizers
                completion(.success(appetizers))
            case .failed:
                completion(.failure(AppError.unableToComplete))
        }
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(UIImage(systemName: "photo.artframe"))
    }
    
    func getAppetizersAsync() async throws -> [AppetizerModel] {
        return []
    }
}
