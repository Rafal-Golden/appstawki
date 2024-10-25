//
//  AccountViewModel.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 09/10/2024.
//

import SwiftUI
import Combine


class AccountViewModel: ObservableObject {
    
    var title: LocalizedStringKey
    
    var userStorage: UserStorage
    var userStorageBag = Set<AnyCancellable>()
    
    var firstSection: LocalizedStringKey
    var firstName: TextItem
    var lastName: TextItem
    var email: TextItem
    var birthday: DateItem
    var birthdayRange: ClosedRange<Date>
    
    var secondSection: LocalizedStringKey
    var extraNapkins: CheckItem
    var allYouCanDrink: CheckItem
    
    @Published var fieldsUpdated: Bool
    
    @Published var saveChangesTitle: LocalizedStringKey
    @Published var saveNotAllowed: Bool
    
    @Published var alertItem: AlertItem?
    
    init() {
        self.title = "AccountTitle"
        self.firstSection = "Personal info:"
        self.firstName = TextItem(name: "First name", value: "", id: .firstName)
        self.lastName = TextItem(name: "Last name", value: "", id: .lastName)
        self.email = TextItem(name: "Email addres", value: "", id: .email)
        self.birthday = DateItem(name: "Birthday")
        self.birthdayRange = Date().oneHundredTenYearsAgo...Date().eightTeenYearsAgo
        
        self.secondSection = "Requests"
        self.extraNapkins = CheckItem(name: "Extra napkins", value: false)
        self.allYouCanDrink = CheckItem(name: "All you can drink", value: false)
        //self.allYouCanDrinkBool = false
        
        self.saveChangesTitle = "save changes"
        self.saveNotAllowed = true
        self.fieldsUpdated = false
        
        self.userStorage = .init()
        configureStorage()
    }
    
    var isValid: Bool {
        var valid = !firstName.value.isEmpty && !lastName.value.isEmpty && !email.value.isEmpty
        valid = valid && email.value.isValidEmail
        saveNotAllowed = !valid
        return valid
    }
    
    func saveChanges() {
        guard isValid else {
            alertItem = AlertContext.accountInvalidData
            return
        }
        
        if userStorage.saveChanges(user: updatedUser()) {
            alertItem = AlertContext.userSavedSuccess
        }
    }
    
    func load() {
        self.userStorage.load()
    }
    
    // MARK: - private functions
    
    private func configureStorage() {
        userStorage.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.setStorageAlert(loading: error is AppError)
        }.store(in: &userStorageBag)
        
        userStorage.$user.sink { [weak self] newUser in
            self?.updateFields(with: newUser)
        }.store(in: &userStorageBag)
    }
    
    private func setStorageAlert(loading: Bool) {
        if loading {
            self.alertItem = AlertContext.accountInvalidData
        } else {
            self.alertItem =  AlertContext.userSavedFailure
        }
    }
    
    private func updateFields(with user: User) {
        birthday.value = user.birthday
        extraNapkins.value = user.extraNapkins
        allYouCanDrink.value = user.allYouCanDrink
        
        firstName.value = user.firstName
        lastName.value = user.lastName
        email.value = user.email
        
        fieldsUpdated = !fieldsUpdated
    }
     
    private func updatedUser() -> User {
        let userUpdated = User(
            firstName: firstName.value,
            lastName: lastName.value,
            email: email.value,
            birthday: birthday.value,
            extraNapkins: extraNapkins.value,
            allYouCanDrink: allYouCanDrink.value
        )
        
        return userUpdated
    }
}
