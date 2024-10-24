//
//  ServiceConfigTests.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 24/10/2024.
//

import Testing
@testable import Appstawki

struct ServiceConfigTests {

    @Test func pathReturnsEndpointURL() async throws {
        let sut = ServiceConfig()
        let endpoint = "strawberries"
        let returnedURL = sut.pathURL(endpoint: endpoint)
        let absoluteUrl = returnedURL?.absoluteString ?? ""
        
        #expect(absoluteUrl.contains(endpoint))
        #expect(returnedURL != nil)
        #expect(returnedURL?.scheme == "https")
    }
    
    @Test func baseURLReturnsValidURL() async throws {
        let sut = ServiceConfig()
        let returnedURL = sut.baseURL
        
        #expect(returnedURL != nil)
        #expect(returnedURL?.scheme == "https")
    }
}
