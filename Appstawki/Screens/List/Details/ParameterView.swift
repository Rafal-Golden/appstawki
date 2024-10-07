//
//  ParameterView.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 07/10/2024.
//

import SwiftUI


struct ParameterView: View {
    
    var name: LocalizedStringKey
    var value: LocalizedStringKey
    
    var body: some View {
        VStack {
            Text(name)
            Text(value)
                .fontWeight(.semibold)
                .italic()
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    GroupBox {
        HStack {
            ParameterView(name: "Calories", value: "121")
            ParameterView(name: "Calories", value: "121")
        }
    }
}
