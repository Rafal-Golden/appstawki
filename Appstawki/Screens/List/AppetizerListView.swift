//
//  ContentView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.appetizers, id: \.id) { item in
                    AppetizerListItemView(item: item)
                }
                .navigationTitle("AppetizersTitle")
            }.onAppear {
                viewModel.getAppetizers()
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
    }
}
