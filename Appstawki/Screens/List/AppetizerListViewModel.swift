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
    @Published var selected: AppetizerModel? = nil
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool
    @Published var isShowingDetails: Bool = false
    
    init(service: NetworkServiceProtocol) {
        self.service = service
        self.isLoading = false
    }
    
    func select(_ item: AppetizerModel) {
        self.selected = item
        self.isShowingDetails = true
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
            }
        }
    }
    
    func getAppetizersTask() {
        isLoading = true
        
        Task { [weak self] in
            do {
                let appetizers = try await self?.service.getAppetizersAsync()
                self?.setAppetizersMain(appetizers ?? [])
            } catch let error {
                let appError = error as? AppError ?? .unableToComplete
                self?.setHandlerMain(appError)
            }
        }
    }
    
    private func setAppetizersMain(_ appetisers: [AppetizerModel]) {        
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.appetizers = appetisers
        }
    }
    
    private func setHandlerMain(_ error: AppError) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.handle(error: error)
        }
    }
    
    func handle(error: AppError) {
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

extension AppetizerListViewModel {
    convenience init() {
        self.init(service: NetworkService())
    }
    
    static func sample(state: NetworkServiceSample.State) -> Self {
        let service = NetworkServiceSample(state: state)
        return Self.init(service: service)
    }
}
