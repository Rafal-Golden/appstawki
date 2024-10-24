//
//  OrderView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var userOrder: Order
    
    var isEmpty: Bool {
        userOrder.isEmpty
    }
    @State var animScale = (min: 0.01, max: 2.0)
    @State var animDuration: Double = 0.66
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.appBackground)
                
                VStack(spacing: 16) {
                    List {
                        ForEach(userOrder.items) { orderItem in
                            AppetizerListItemView(item: orderItem)
                        }.onDelete(perform: userOrder.deleteItems)
                            
                    }
                    .background(.clear)
                    .listStyle(.plain)
                    .listRowSeparator(.visible)
                    
                    AppButton(title: "\(userOrder.totalPriceString) - Order placed") {
                        userOrder.sentToExecution()
                    }
                    .largeStyle()
                }
                .mask(
                    Circle()
                        .scale(isEmpty ? animScale.min : animScale.max)
                        .opacity(1.0)
                        .offset(y: -60)
                        .animation(.easeIn(duration: animDuration), value: !isEmpty)
                )
                EmptyStateView(imageName: "basket", message: "OrderViewEmptyMessage")
                    .opacity(isEmpty ? 1 : 0)
                    .animation(.easeInOut(duration: animDuration), value: isEmpty)
            }
            .background(.appBackground)
            .navigationTitle("OrderTitle")
#if DEBUG
                .navigationBarItems(trailing: Button("Add Order", action: addOrderTest))
#endif
        }
    }
    
    func addOrderTest() {
        withAnimation {
            userOrder.items.append(MockData.orderItemThree)
        }
    }
}

#Preview {
    var order = Order()
    order.items = MockData.orderItems
    return OrderView().environmentObject(order)
}
