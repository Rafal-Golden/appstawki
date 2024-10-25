//
//  AccountTextField.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 25/10/2024.
//
import SwiftUI


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
