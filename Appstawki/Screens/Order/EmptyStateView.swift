//
//  EmptyStateView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 22/10/2024.
//

import SwiftUI

struct EmptyStateView: View {
    @State var imageName: String
    @State var message: LocalizedStringKey
    
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.brandPrimary)
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -20)
        }
    }
}

#Preview {
    EmptyStateView(imageName: "basket", message: "OrderViewEmptyMessage")
}
