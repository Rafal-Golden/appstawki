//
//  ContentView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel: AppetizerListViewModel
    
    var body: some View {
        ZStack {
            Color(.red)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                List(viewModel.appetizers, id: \.id) { item in
                    AppetizerListItemView(item: item)
                        .onTapGesture {
                        viewModel.select(item)
                    }
                }
                .disabled(viewModel.isShowingDetails)
                .navigationTitle("AppetizersTitle")
            }.onAppear {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetails ? 20 : 0)
            
            if let selected = viewModel.selected, viewModel.isShowingDetails {
                let selectedDetailsVM = AppetizerDetailsViewModel(model: selected)
                AppetizerDetailsView(viewModel: selectedDetailsVM, isShowing: $viewModel.isShowingDetails)
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

#Preview("Remote Service") {
    AppetizerListView(viewModel: .init())
}

#Preview("Sample Service") {
    AppetizerListView(viewModel: .sample(state: .success))
}

