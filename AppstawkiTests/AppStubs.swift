//
//  AppStubs.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 11/10/2024.
//

import Foundation
@testable import Appstawki

struct AppStubs {
    struct AppetizerModels {
        static let cucamber = AppetizerModel(id: 0001,
                                                     name: "cucamber",
                                                     description: "Cucamber slices with majonese topping. It's yummy.",
                                                     price: 9.99,
                                                     imageURL: URL(string: "https://")!,
                                                     calories: 99,
                                                     protein: 99,
                                                     carbs: 99)
        
        static let avocado = AppetizerModel(id: 0002,
                                                    name: "Avocado Delight",
                                                    description: "Fresh avocado slices served with a tangy lemon dressing and chili flakes. A refreshing, healthy snack with a kick.",
                                                    price: 12.99,
                                                    imageURL: URL(string: "https://example.com/avocado.png")!,
                                                    calories: 120,
                                                    protein: 3,
                                                    carbs: 76)
        static let grilledChickenBites = AppetizerModel(id: 0003,
                                                        name: "Grilled Chicken Bites",
                                                        description: "Tender grilled chicken bites served with a side of honey mustard sauce. A perfect protein-packed snack.",
                                                        price: 14.99,
                                                        imageURL: URL(string: "https://example.com/chicken.png")!,
                                                        calories: 220,
                                                        protein: 30,
                                                        carbs: 5)
        
        static let avocadoDetailsViewModel = AppetizerDetailsViewModel(model: avocado)
        
        static let appetizers = [cucamber, avocado, grilledChickenBites]
        
        static let appetizerResponse = AppetizerResponse(request: appetizers)
        
        static func appetizerURLResponse() -> HTTPURLResponse? {
            return HTTPURLResponse(url: URL(string: "https://")!, statusCode: 200, httpVersion: "1.0", headerFields: nil)
        }
        
        static func appetizerData() -> Data? {
            let response = AppStubs.AppetizerModels.appetizerResponse
            do {
              let data = try JSONEncoder().encode(response)
                return data
            } catch {
                print("[AppStubs] \(#function) Encoding error \(error)")
            }
            return nil
        }
    }
    
    class URLResponseStubs: HTTPURLResponse {
        
        convenience init?(statusCode: Int) {
            self.init(url: URL(string: "https://")!, statusCode: statusCode, httpVersion: "1.0", headerFields: nil)
        }
        
        static var response200: URLResponseStubs? {
            URLResponseStubs(statusCode: 200)
        }
    }
    
    class NSErrors: NSError {
        
        convenience init(code: Int) {
            self.init(domain: "StubUnitTest", code: code)
        }
        static let failsWith404 = NSErrors(code: 404)
    }
}
