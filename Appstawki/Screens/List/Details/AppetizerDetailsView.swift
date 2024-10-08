//
//  AppetizerDetailsView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 07/10/2024.
//

import SwiftUI

struct AppetizerDetailsView: View {
    
    var model: AppetizerModel {
        viewModel.model
    }
    let viewModel: AppetizerDetailsViewModel

    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            AppRemoteImage(url: model.imageURL)
                .aspectRatio(contentMode: .fit)
                .background(Color.gray)
                .frame(maxWidth: .infinity)
            
            VStack {
                Text(model.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(model.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                HStack(spacing: 20) {
                    ParameterView(name: "Calories", value: "\(model.calories)")
                    ParameterView(name: "Carbs", value: "\(model.carbs)")
                    ParameterView(name: "Proitein", value: "\(model.protein)")
                }
            }
                .padding()
                .foregroundColor(.primary)
            
            
            AppButton(title: viewModel.orderButtonTitle) {
                // add
            }
        }
        //.frame(width: UIScreen.main.bounds.width * 0.8)
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
