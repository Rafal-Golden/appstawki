//
//  AppetizerListViewModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import Foundation

final class AppetizerListViewModel: ObservableObject {
    
    let service: NetworkServiceProtocol
    
    @Published var appetizers: [AppetizerModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool
    
    init() {
        self.service = NetworkService()
        self.isLoading = false
    }
    
    func getAppetizers() {
        isLoading = true
        
        service.getAppetizers { [weak self] result in
            self?.isLoading = false
            switch result {
                case .success(let appetizers):
                    self?.appetizers = appetizers
                    
                case .failure(let error):
                    self?.appetizers = []
                    self?.handle(error: error)
                    print("Error \(error)")
            }
        }
    }
    
    func handle(error: NetworkService.AppError) {
        switch error {
            case .undefinedURL:
                alertItem = AlertContext.invalidURL
            case .unableToComplete:
                alertItem = AlertContext.canNotComplete
            case .invalidData:
                alertItem = AlertContext.invalidData
            case .parsingFailed(let error):
                alertItem = AlertContext.Alert(with: error)
        }
    }
}
