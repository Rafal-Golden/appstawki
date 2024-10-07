//
//  AppetizerListItemView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 04/10/2024.
//

import SwiftUI


struct AppetizerListItemView: View {
    
    let item: AppetizerModel
    
    var body: some View {
        HStack {
            AppRemoteImage(url: item.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 80)
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("$\(item.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
                    .fontWeight(.regular)
                //Text("\(item.imageURL)")
            }
            .padding(.leading)
        }
    }
}


#Preview {
    AppetizerListItemView(item: MockData.sampleAppetizer)
}
