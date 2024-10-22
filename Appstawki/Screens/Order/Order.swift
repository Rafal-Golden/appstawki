//
//  Order.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 22/10/2024.
//

import SwiftUI

final class Order: ObservableObject {
    
    @Published var items: [AppetizerModel] = []
    private var currencyFormatter = CurrencyFormatter()
    
    func add(_ item: AppetizerModel) {
        items.append(item)
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    var totalPrice: Double {
        items.reduce(0, { $0 + $1.price })
    }
    
    var totalPriceString: String {
        currencyFormatter.string(from: totalPrice)
    }
}

