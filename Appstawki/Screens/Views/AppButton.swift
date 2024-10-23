//
//  AppButton.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 07/10/2024.
//

import SwiftUI


struct AppButton: View {
    var title: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }.padding(20)
    }
    
    func largeStyle() -> some View {
        self.buttonStyle(AppButtonLargeStyle())
    }
    
    func simpleStyle() -> some View {
        self.modifier(AppButtonSimpleStyle())
    }
}

#Preview("Button Styles") {
    Group {
        AppButton(title: "\("12") AddToOrderTitle", action: {})
            .largeStyle()
            .environment(\.locale, Locale(identifier: "en_US"))
        AppButton(title: "\("12") AddToOrderTitle", action: {})
            .simpleStyle()
            .environment(\.locale, Locale(identifier: "pl_PL"))
        AppButton(title: "\("12") AddToOrderTitle", action: {})
            .largeStyle()
            .environment(\.locale, Locale(identifier: "pl_PL"))
    }
}
