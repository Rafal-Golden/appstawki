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
        let formatter = CurrencyFormatter()
        return formatter.string(from: price)
    }
}

struct AppetizerResponse: Codable {
    let request: [AppetizerModel]
}

