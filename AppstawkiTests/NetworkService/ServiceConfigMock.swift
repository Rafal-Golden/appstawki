//
//  ServiceConfigMock.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 24/10/2024.
//
import Foundation
@testable import Appstawki


class ServiceConfigMock: ServiceConfigProtocol {
    var baseURL: URL?
    var pathURLReturnedURL: URL?
    var pathURLCalled = false
    
    init() {
        self.baseURL = URL(string: "https://service.unittest.local/")
        self.pathURLReturnedURL = baseURL?.appending(component: "fake")
    }
    
    func pathURL(endpoint: String) -> URL? {
        pathURLCalled = true
        return pathURLReturnedURL
    }
    
    func setInvalidPath() {
        pathURLReturnedURL = nil
    }
}
