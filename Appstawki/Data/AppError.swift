//
//  File.swift
//  AppstawkiTests
//
//  Created by Rafal Korzynski on 15/10/2024.
//

import Foundation


enum AppError: Error, Equatable {
    
    case undefinedURL
    case unableToComplete
    case invalidData
    case parsingFailed(Error)
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.undefinedURL, .undefinedURL),
             (.unableToComplete, .unableToComplete),
             (.invalidData, .invalidData):
            return true
        case (.parsingFailed(let errorL), .parsingFailed(let errorR)):
                return errorL.localizedDescription == errorR.localizedDescription
        default:
            return false
        }
    }
}
