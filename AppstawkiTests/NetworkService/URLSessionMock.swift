//
//  URLSessionMock.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 11/10/2024.
//

import Foundation
@testable import Appstawki


final class URLSessionMock: URLSessionProtocol {
    
    var returnedData: Data?
    var returnedResponse: URLResponse?
    var returnedError: (any Error)?
    
    var isCompletionCalled: Bool = false
    
    class URLSessionDataTaskStub: URLSessionDataTask {
        var wasResumeCalled = false
        
        override func resume() {
            wasResumeCalled = true
        }
    }
    
    var dataTask = URLSessionDataTaskStub()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        isCompletionCalled = true
        completionHandler(returnedData, returnedResponse, returnedError)
        
        return dataTask
    }
    
    func data(from url: URL,
              delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        isCompletionCalled = true
        if let returnedError {
            throw returnedError
        }
        if let data = returnedData, let response = returnedResponse {
            return (data, response)
        }
        return (Data(), URLResponse())
    }
}
