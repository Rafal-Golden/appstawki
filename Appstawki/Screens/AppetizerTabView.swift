//
//  AppetizerTabView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct AppetizerTabView: View {
    
    let module = AppModule()
    
    var body: some View {
        TabView {
            AppetizerListView(viewModel: module.injectAppetizerListViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("HomeTab")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("AccountTab")
                }
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("OrderTab")
                }
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
