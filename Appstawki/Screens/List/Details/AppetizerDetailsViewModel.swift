//
//  AppetizerDetailsViewModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 08/10/2024.
//

import SwiftUI


final class AppetizerDetailsViewModel: ObservableObject {
    
    let model: AppetizerModel
    
    init(model: AppetizerModel) {
        self.model = model
    }
    
    var orderButtonTitle: LocalizedStringKey {
        let localPrice = model.priceWithCurrency
        return LocalizedStringKey("\(localPrice) AddToOrderTitle")
    }
}
