//
//  NetworkServiceModernTests.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 24/10/2024.
//

import Testing
import Foundation

@testable import Appstawki


struct NetworkServiceModernTests {

    let sessionMock: URLSessionMock
    let serviceConfigMock: ServiceConfigMock
    
    init() {
        sessionMock = URLSessionMock()
        serviceConfigMock = ServiceConfigMock()
    }
    
    func makeSUT() -> NetworkServiceProtocol {
        let queueMock = AppQueueMock()
        let imageCacheMock = ImageCacheMock()
        
        return NetworkService(urlSession: sessionMock, queue: queueMock, cache: imageCacheMock, config: serviceConfigMock)
    }
    
    func setupSession(server: AppStubs.URLResponseStubs?, returnedError: AppStubs.NSErrors?) {
        sessionMock.returnedData = AppStubs.AppetizerModels.appetizerData()
        sessionMock.returnedResponse = server
        sessionMock.returnedError = returnedError
    }
    
    @Test("Get Appetiser list from server fails", arguments: [
        AppError.unableToComplete,
        AppError.undefinedURL,
    ])
    func getAppetizersFailure(expectedError: AppError) async throws {
        let sut = makeSUT()
        setupSession(server: .response200, returnedError: .failsWith404)
        
        if expectedError == .undefinedURL {
            serviceConfigMock.setInvalidPath()
        }
        
        var resultError: AppError?
        
        sut.getAppetizers { result in
            if case .failure(let error) = result {
                resultError = error
            }
        }
        
        #expect(resultError == expectedError)
    }
    
    @Test(arguments: [
        (nil, nil),
        (AppStubs.URLResponseStubs.response200, AppStubs.NSErrors.failsWith404),
        (AppStubs.URLResponseStubs.response200, nil),
        (nil, AppStubs.NSErrors.failsWith404),
    ])
    func getAppetizersTriggersSession(response: AppStubs.URLResponseStubs?, returnedError: AppStubs.NSErrors?) async throws {
        let sut = makeSUT()
        setupSession(server: response, returnedError: returnedError)
        
        sut.getAppetizers {_ in }
        
        #expect(sessionMock.isCompletionCalled)
        #expect(sessionMock.dataTask.wasResumeCalled)
    }
}
