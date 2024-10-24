//
//  NetworkServiceSession.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 11/10/2024.
//

import UIKit
import Foundation

protocol AppQueueProtocol {
    func onMainAsync(_ block: @escaping () -> Void)
}
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask
    func data(from url: URL,
              delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

struct AppQueue: AppQueueProtocol {
    private let queue: DispatchQueue = .main
    
    func onMainAsync(_ block: @escaping () -> Void) {
        queue.async {
            block()
        }
    }
}
