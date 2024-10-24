//
//  AccountView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    @FocusState private var focusedTextField: TextItem.ID?
    
    private func textField(item: TextItem) -> some View {
        let textField = TextField(item.name, text: Binding (
            get: { item.value },
            set: { item.value = $0 }
        ))
        return textField.focused($focusedTextField, equals: item.id)
            .onSubmit { focusedTextField = item.id.next }
            .submitLabel(item.id.next != nil ? .next : .continue)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text(viewModel.firstSection)) {
                        TextFieldGroup {
                            textField(item: viewModel.firstName)
                            textField(item: viewModel.lastName)
                            TextFieldEmailView(item: viewModel.email)
                                .focused($focusedTextField, equals: .email)
                                .onSubmit { focusedTextField = viewModel.email.id.next }
                        }
                        DatePicker(viewModel.birthday.name, selection: $viewModel.birthday.value, displayedComponents: .date)
                    }
                    
                    Section(header: Text(viewModel.secondSection)) {
                        Toggle(viewModel.extraNapkins.name, isOn: $viewModel.extraNapkins.value)
                        Toggle(viewModel.allYouCanDrink.name, isOn: $viewModel.allYouCanDrink.value)
                            .id(viewModel.fieldsUpdated)
                    }.toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                }
                AppButton(title: viewModel.saveChangesTitle, action: viewModel.saveChanges)
                    .simpleStyle()
                    .opacity(viewModel.saveNotAllowed ? 0.6 : 1.0)
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") { focusedTextField = nil }
                }
            }
            .onAppear {
                viewModel.load()
            }
            .alert(item: $viewModel.alertItem) { item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            }
        }
    }
}

struct AccountTextField: View {
    @StateObject var item: TextItem
    
    var body: some View {
        TextField(item.name, text: Binding (
            get: { item.value },
            set: { item.value = $0 }
        ))
    }
}

struct AccountTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.background()
    }
}

struct TextFieldGroup<Content: View>: View {
    
    @FocusState private var focusedTextField: TextItem.ID?
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}

#Preview {
    AccountView()
}
