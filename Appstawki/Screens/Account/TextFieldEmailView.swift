//
//  TextFieldEmailView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 10/10/2024.
//

import SwiftUI

struct TextFieldEmailView: View {
    
    @StateObject var item: TextItem
    @State var isValid: Bool = true
    
    var body: some View {
        TextField(item.name, text: Binding (
            get: { item.value },
            set: { item.value = $0 }
        ))
        .onChange(of: item.value) { newValue in
            isValid = newValue.isValidEmail
        }
        .foregroundColor(isValid ? .primary: .red)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .autocorrectionDisabled()
    }
}

#Preview {
    let item = TextItem(name: "Name", value: "", id: .email)
    TextFieldEmailView(item: item)
        .padding()
        .border(.blue)
}
