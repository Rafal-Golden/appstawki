//
//  AppstawkiTests.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import XCTest
import Nimble
@testable import Appstawki


final class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceProtocol!
    
    var sessionMock: URLSessionMock!
    var queueMock: AppQueueMock!
    var imageCacheMock: ImageCacheMock!
    var serviceConfigMock: ServiceConfigMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sessionMock = URLSessionMock()
        queueMock = AppQueueMock()
        imageCacheMock = ImageCacheMock()
        serviceConfigMock = ServiceConfigMock()
        sut = NetworkService(urlSession: sessionMock, queue: queueMock, cache: imageCacheMock, config: serviceConfigMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        queueMock = nil
        sessionMock = nil
        imageCacheMock = nil
        serviceConfigMock = nil
        sut = nil
    }
    
    func test_getAppetizersCallsSessionResume() throws {
        
        sut.getAppetizers { _ in }
        
        expect(self.sessionMock.dataTask.wasResumeCalled).to(beTrue())
        expect(self.sessionMock.isCompletionCalled).to(beTrue())
        expect(self.serviceConfigMock.pathURLCalled).to(beTrue())
    }
    
    func test_getAppetizersFailsDataTaskReturnsErrorUnableToComplete() throws {
        sessionMock.returnedError = AppStubs.NSErrors.failsWith404
        let expectedError = setupExpected(error: .unableToComplete, response: .response200)
        var returnedError: AppError?
        
        sut.getAppetizers { result in
            if case .failure(let error) = result {
                returnedError = error
            }
        }
        
        expect(returnedError).to(equal(expectedError))
        
        expect(self.sessionMock.dataTask.wasResumeCalled).to(beTrue())
        expect(self.sessionMock.isCompletionCalled).to(beTrue())
    }
    
    func test_getAppetizersFailsAndReturnsErrorUndefinedURL() throws {
        sessionMock.returnedError = AppStubs.NSErrors.failsWith404
        serviceConfigMock.pathURLReturnedURL = nil
        let expectedError = setupExpected(error: .undefinedURL, response: .response200)
        
        var returnedError: AppError?
        
        sut.getAppetizers { result in
            if case .failure(let error) = result {
                returnedError = error
            }
        }
        
        expect(returnedError).to(equal(expectedError))
    }

    func test_getAppetizersSuccessReturnsArray() throws {
        let expectedError = setupExpected(error: nil, response: .response200)
        
        var isCompletionCalled = false
        var results: [Any] = []
        
        sut.getAppetizers { result in
            isCompletionCalled = true
            if case .success(let successResults) = result {
                results = successResults
            }
        }
        
        expect(isCompletionCalled).to(beTrue())
        expect(results).toNot(beEmpty())
        expect(expectedError).to(beNil())
    }
    
    func setupExpected(error: AppError?,
                       response: AppStubs.URLResponseStubs?) -> AppError? {
        sessionMock.returnedData = AppStubs.AppetizerModels.appetizerData()
        sessionMock.returnedResponse = response
        return error
    }
    
    func test_getAppetizersResponseFailsReturnsErrorUnableToComplete() throws {
        let expectedError = setupExpected(error: .unableToComplete, response: nil)
        
        var isCompletionCalled = false
        var returnedError: AppError?
        
        sut.getAppetizers { result in
            isCompletionCalled = true
            if case .failure(let error) = result {
                returnedError = error
            }
        }
        
        expect(isCompletionCalled).to(beTrue())
        expect(returnedError).to(equal(expectedError))
    }
    
    // MARK: - Download Image
    
    func test_getDownloadImageCallsSessionResume() throws {
        
        let fakeUrl = URL(string: "https://fakeurl")!
        sut.downloadImage(url: fakeUrl) { image in
        }
        
        expect(self.sessionMock.dataTask.wasResumeCalled).to(beTrue())
        expect(self.sessionMock.isCompletionCalled).to(beTrue())
    }
    
    
    
    func test_getDownloadImageFailsReturnsImage() throws {
        sessionMock.returnedData = nil
        
        let fakeUrl = URL(string: "https://fakeurl_2")!
        var returnedImage: UIImage?
        
        sut.downloadImage(url: fakeUrl) { image in
            returnedImage = image
        }
        
        expect(returnedImage).to(beNil())
    }
    
    func test_getDownloadImageSuccessReturnsImage() throws {
        sessionMock.returnedData = UIImage(systemName: "photo")?.pngData()
        
        let fakeUrl = URL(string: "https://fakeurl")!
        var returnedImage: UIImage?
        
        sut.downloadImage(url: fakeUrl) { image in
            returnedImage = image
        }
        
        expect(returnedImage).toNot(beNil())
    }
    
    func test_getAppetizersAsyncCallsSession() async throws {
        
        var appetisers: [AppetizerModel]?
        var expectedError: AppError?
        do {
            appetisers = try await sut.getAppetizersAsync()
        } catch let error {
            expectedError = error as? AppError
        }
        
        expect(expectedError).to(equal(AppError.unableToComplete))
        expect(appetisers).to(beNil())
        expect(self.sessionMock.dataTask.wasResumeCalled).to(beFalse())
        expect(self.sessionMock.isCompletionCalled).to(beTrue())
    }
    
    func test_getAppetizersAsyncReturnsOnMainThread() async throws {
        
        let appetisers = try? await sut.getAppetizersAsync()
        
        expect(Thread.isMainThread).to(beFalse())
    }
    
    func test_getAppetizersAsyncFailsAndReturnsError() async throws {
        sessionMock.returnedError = AppStubs.NSErrors.failsWith404
        serviceConfigMock.pathURLReturnedURL = nil
        let expectedError = setupExpected(error: .undefinedURL, response: .response200)
        var returnedError: AppError?
        
        do {
            let _ = try await sut.getAppetizersAsync()
        } catch let error {
            returnedError = error as? AppError
        }
        
        expect(returnedError).to(equal(expectedError))
    }
}
