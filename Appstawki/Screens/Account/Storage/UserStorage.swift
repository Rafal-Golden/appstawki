//
//  UserStorage.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 21/10/2024.
//


import SwiftUI


class UserStorage: ObservableObject {
    
    @AppStorage("user") var userData: Data?
    @Published var user: User
    @Published var error: Error?
    
    init() {
        self.user = User()
    }
    
    func saveChanges(user: User) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .secondsSince1970
            let data = try encoder.encode(user)
            userData = data
            self.user = user
        } catch {
            self.error = error
            return false
        }
        return true
    }
    
    func load() {
        guard let userData else { return }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            user = try decoder.decode(User.self, from: userData)
        } catch {
            self.error = AppError.invalidData
        }
    }
}
