//
//  AlertContext.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title, message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let canNotComplete = Alert(title: "Server response error!", message: "Something wrong with server. Try again later.", buttonTitle: "OK")
    static let invalidData = Alert(title: "Invalid data!", message: "Sorry :( \nSomething wrong with parsing server json data objects.", buttonTitle: "OK")
    static let invalidURL = Alert(title: "Invalid URL!", message: "Sorry :( \nSomething wrong with your URL.", buttonTitle: "OK")
    
    static let accountInvalidData = Alert(title: "Invalid personal data", message: "Please make sure you fullfiled form with all personal info.", buttonTitle: "OK")
    
    static let userSavedSuccess = Alert(title: "User saved", message: "User data saved successfuly.", buttonTitle: "OK")
    static let userSavedFailure = Alert(title: "User saved", message: "Sorry! But user data could not be saved successfuly.", buttonTitle: "OK")
    
    static func Alert(with error: Error) -> AlertItem {
        Alert(title: "Server error", message: "JSON Parsing error \(error)", buttonTitle: "OK")
    }
    
    static func Alert(title: String, message: String, buttonTitle: String) -> AlertItem {
        AlertItem(title: Text(title),
              message: Text(message),
              dismissButton: .default(Text(buttonTitle)))
    }
}
