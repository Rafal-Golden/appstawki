//
//  AppQueueMock.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 16/10/2024.
//

@testable import Appstawki


struct AppQueueMock: AppQueueProtocol {
    func onMainAsync(_ block: @escaping () -> Void) {
        block()
    }
}
