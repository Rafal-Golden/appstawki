//
//  AccountView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    private func textField(item: TextItem) -> some View {
        TextField(item.name, text: Binding (
            get: { item.value },
            set: { item.value = $0 }
        ))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text(viewModel.firstSection)) {
                        textField(item: viewModel.firstName)
                        textField(item: viewModel.lastName)
                        TextFieldEmailView(item: viewModel.email)
                        DatePicker(viewModel.birthday.name, selection: $viewModel.birthday.value, displayedComponents: .date)
                    }
                    
                    Section(header: Text(viewModel.secondSection)) {
                        Toggle(viewModel.extraNapkins.name, isOn: $viewModel.extraNapkins.value)
                        Toggle(viewModel.allYouCanDrink.name, isOn: $viewModel.allYouCanDrink.value)
                    }.toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                }
                AppButton(title: viewModel.saveChangesTitle, action: viewModel.saveChanges)
                    .opacity(viewModel.saveNotAllowed ? 0.6 : 1.0)
            }
            .navigationTitle(viewModel.title)
            .alert(item: $viewModel.alertItem) { item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            }
        }
    }
}

#Preview {
    AccountView()
}
