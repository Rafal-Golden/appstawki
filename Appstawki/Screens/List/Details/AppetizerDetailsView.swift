//
//  AppetizerDetailsView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 07/10/2024.
//

import SwiftUI

struct AppetizerDetailsView: View {
    
    @EnvironmentObject var order: Order
    
    var item: AppetizerModel {
        viewModel.model
    }
    let viewModel: AppetizerDetailsViewModel

    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            AppRemoteImage(url: item.imageURL)
                .aspectRatio(contentMode: .fit)
                .background(Color.gray)
                .frame(maxWidth: .infinity)
            
            VStack {
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(item.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                HStack(spacing: 20) {
                    ParameterView(name: "Calories", value: "\(item.calories)")
                    ParameterView(name: "Carbs", value: "\(item.carbs)")
                    ParameterView(name: "Protein", value: "\(item.protein)")
                }
            }
                .padding()
                .foregroundColor(.primary)
            
            
            AppButton(title: viewModel.orderButtonTitle) {
                order.add(item)
                isShowing = false
            }
            .simpleStyle()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 20)
        .overlay(CloseButton(){ isShowing = false }, alignment: .topTrailing)
        .padding(50.0)
    }
}

#Preview {
    AppetizerDetailsView(viewModel: MockData.sampleDetailsViewModel, isShowing: .constant(false))
        .environment(\.locale, Locale(identifier: "pl_PL"))
}
