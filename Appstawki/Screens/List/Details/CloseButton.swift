//
//  CloseButton.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 07/10/2024.
//

import SwiftUI


struct CloseButton: View {

    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack
            {
                Circle()
                    .frame(width: 30, height: 30)
                    .padding()
                    .foregroundColor(.white.opacity(0.6))
                Image(systemName: "xmark")
                    .imageScale(.small)
                    .foregroundColor(Color(.label))
                    .frame(width: 40, height: 40)
            }
        }
    }
}

#Preview {
    CloseButton(action: {})
}
