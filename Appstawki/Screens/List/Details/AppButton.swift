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
                .font(.title3)
                .fontWeight(.semibold)
                .padding(20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.appPrimary)
                .cornerRadius(10)
        }.padding(20)
    }
}

#Preview {
    Group {
        AppButton(title: "\("12") AddToOrderTitle", action: {})
            .previewDisplayName("Default Locale")
            .environment(\.locale, Locale(identifier: "en_US"))
        AppButton(title: "\("12") AddToOrderTitle", action: {})
            .previewDisplayName("Polish Locale")
            .environment(\.locale, Locale(identifier: "pl_PL"))
    }
}
