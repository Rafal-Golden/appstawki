//
//  OrderView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("🧾")
                    .font(.largeTitle)
                Text("Order")
            }
            .navigationTitle("OrderTitle")
        }
    }
}

#Preview {
    OrderView()
}
