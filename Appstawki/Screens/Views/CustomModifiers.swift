//
//  CustomModifiers.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 23/10/2024.
//

import SwiftUI


struct AppButtonSimpleStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.appPrimary)
            .controlSize(.large)
    }
}

struct AppButtonLargeStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .padding(20)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.appPrimary)
            .cornerRadius(10)
    }
}
