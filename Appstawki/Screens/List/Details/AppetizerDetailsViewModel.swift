//
//  AppetizerDetailsViewModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 08/10/2024.
//

import SwiftUI


final class AppetizerDetailsViewModel: ObservableObject {
    let model: AppetizerModel
    
    var localCurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
         formatter.numberStyle = .currency
         formatter.locale = .current
        return formatter
    }
    
    init(model: AppetizerModel) {
        self.model = model
    }
    
    var orderButtonTitle: LocalizedStringKey {
        let price = NSNumber(value: model.price)
        let priceWithCurrency = localCurrencyFormatter.string(from: price) ?? "\(price)"
        return LocalizedStringKey("\(priceWithCurrency) AddToOrderTitle")
    }
}
