//
//  AppModule.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 16/10/2024.
//

import Foundation

struct AppModule {
    
    func injectAppetizerListViewModel() -> AppetizerListViewModel {
        let service = NetworkService()
        return AppetizerListViewModel(service: service)
    }
}
