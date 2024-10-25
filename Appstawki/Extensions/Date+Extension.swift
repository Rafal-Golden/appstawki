//
//  Date+Extension.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 25/10/2024.
//
import Foundation


extension Date {
    var oneHundredTenYearsAgo: Date {
        yearsAgo(passed: 110)
    }
    
    var eightTeenYearsAgo: Date {
        yearsAgo(passed: 18)
    }
    
    func yearsAgo(passed: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: -passed, to: self) ?? self
    }
}
