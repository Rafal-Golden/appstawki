//
//  AccountViewModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 09/10/2024.
//

import SwiftUI

class AccountViewModel: ObservableObject {
    
    var title: LocalizedStringKey
    @Published var firstSection: LocalizedStringKey
    @Published var firstName: TextItem
    @Published var lastName: TextItem
    @Published var email: TextItem
    @Published var birthday: DateItem
    
    @Published var secondSection: LocalizedStringKey
    @Published var extraNapkins: CheckItem
    @Published var allYouCanDrink: CheckItem
    
    @Published var saveChangesTitle: LocalizedStringKey
    @Published var saveNotAllowed: Bool
    
    @Published var alertItem: AlertItem?
    
    init() {
        self.title = "AccountTitle"
        self.firstSection = "Personal info:"
        self.firstName = TextItem(name: "First name", value: "")
        self.lastName = TextItem(name: "Last name", value: "")
        self.email = TextItem(name: "Email addres", value: "")
        self.birthday = DateItem(name: "Birthday")
        
        self.secondSection = "Requests"
        self.extraNapkins = CheckItem(name: "Extra napkins", value: false)
        self.allYouCanDrink = CheckItem(name: "All you can drink", value: false)
        
        self.saveChangesTitle = "save changes"
        self.saveNotAllowed = true
    }
    
    var isValid: Bool {
        var valid = !firstName.value.isEmpty && !lastName.value.isEmpty && !email.value.isEmpty
        valid = valid && email.value.isValidEmail
        saveNotAllowed = !valid
        return valid
    }
    
    func saveChanges() {
        if isValid {
            print("save changes executed")
        } else {
            alertItem = AlertContext.accountInvalidData
        }
    }
}
