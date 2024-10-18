//
//  SnapshotsTests.swift
//  SnapshotsTests
//
//  Created by Rafal Korzynski on 11/10/2024.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import Appstawki


final class AppetizerListViewTests: XCTestCase {

    var sut: UIViewController!
    
    override func setUpWithError() throws {
        //isRecording = true
    }
    
    func makeSUT(state: NetworkServiceSample.State) {
        let service = NetworkServiceSample(state: state)
        
        let viewModel = AppetizerListViewModel(service: service)
        let view = AppetizerListView(viewModel: viewModel)
        sut = UIHostingController(rootView: view)
        
        sut.overrideUserInterfaceStyle = .light
        sut.view.layoutIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_AppetizerListViewIsLoading() throws {
        makeSUT(state: .loading)
        assertSnapshots(of: sut, as: [.image(on: .iPhoneSe(.portrait))] )
    }
    
    func test_AppetizerListViewLoadedData() throws {
        makeSUT(state: .success)
        assertSnapshots(of: sut, as: [.image(on: .iPhoneSe(.portrait))] )
    }
    
    func test_AppetizerListViewLoadingFailed() throws {
        makeSUT(state: .failed)
        
        let expectation = XCTestExpectation(description: "Wait for Alert to appear")
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            expectation.fulfill()
        }
        wait(for: [expectation])
        
        assertSnapshots(of: sut, as: [.image(on: .iPhoneSe(.portrait))] )
    }
}
