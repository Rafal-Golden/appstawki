//
//  AppetizerTabView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AppetizerTabView: View {
    
    let module = AppModule()
    @EnvironmentObject var order: Order
    
    var body: some View {
        TabView {
            AppetizerListView(viewModel: module.injectAppetizerListViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("HomeTab")
                }
            AccountView()
                .tabItem {
                    Label("AccountTab", systemImage: "person")
                }
            OrderView()
                .tabItem { Label("OrderTab", systemImage: "bag") }
                .badge(order.items.count)
        }
        .accentColor(Color("BrandPrimary"))
    }
}

#Preview {
    Group {
        AppetizerTabView()
            .environment(\.locale, Locale(identifier: "pl"))
    }
}
