//
//  OrderView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var userOrder: Order
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 16) {
                    List {
                        ForEach(userOrder.items) { orderItem in
                            AppetizerListItemView(item: orderItem)
                        }.onDelete(perform: userOrder.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    AppButton(title: "\(userOrder.totalPriceString) - Order placed") {
                        print("do action")
                    }
                    .padding(.bottom, 25)
                }
                if userOrder.isEmpty {
                    EmptyStateView(imageName: "basket", message: "OrderViewEmptyMessage")
                }
            }
            .navigationTitle("OrderTitle")
        }
    }
}

#Preview {
    OrderView()
}
