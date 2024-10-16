//
//  AppetizerModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import Foundation


struct AppetizerModel: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: URL
    let calories: Int
    let protein: Int
    let carbs: Int
}

extension AppetizerModel {
    
    var priceWithCurrency: String {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

struct AppetizerResponse: Codable {
    let request: [AppetizerModel]
}

