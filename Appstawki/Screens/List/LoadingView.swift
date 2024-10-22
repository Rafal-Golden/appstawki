//
//  LoadingView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIActivityIndicatorView {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = UIColor.appPrimary
        activity.startAnimating()
        return activity
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ActivityIndicator()
        }
    }
}
