//
//  EmptyView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct EmptyView: View {
    
    var viewModel = EmptyViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.title)
                .frame(height: 45)
                .font(Font.Poppins(weight: 600, size: 30))
                .foregroundColor(Color.weather.textPrimary)
                .padding(8)
            Text(viewModel.description)
                .font(Font.Poppins(weight: 600, size: 15))
                .foregroundColor(Color.weather.textPrimary)
        }
        .padding()
    }
}

#Preview {
    EmptyView()
}
