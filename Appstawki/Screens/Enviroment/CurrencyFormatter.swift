//
//  CurrencyFormatter.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 22/10/2024.
//
import Foundation


class CurrencyFormatter {
    var localCurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
         formatter.numberStyle = .currency
         formatter.locale = .current
        return formatter
    }
    
    func string(from price: Double) -> String {
        let priceValue = NSNumber(value: price)
        let priceWithCurrency = localCurrencyFormatter.string(from: priceValue) ?? "\(priceValue)"
        return priceWithCurrency
    }
}
