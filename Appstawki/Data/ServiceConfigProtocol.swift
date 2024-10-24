//
//  ServiceConfigProtocol.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 24/10/2024.
//
import Foundation


protocol ServiceConfigProtocol {
    var baseURL: URL? { get }
    func pathURL(endpoint: String) -> URL?
}

struct ServiceConfig: ServiceConfigProtocol {
    var baseURL: URL? {
        URL(string: "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/")
    }
    
    func pathURL(endpoint: String) -> URL? {
        return baseURL?.appending(component: endpoint)
    }
}
