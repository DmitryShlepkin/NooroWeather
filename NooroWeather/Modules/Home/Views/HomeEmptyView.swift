//
//  HomeEmptyView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct HomeEmptyView: View {
        
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .frame(height: 45)
                .font(Font.Poppins(weight: 600, size: 30))
                .foregroundColor(Color.weather.textPrimary)
                .padding(8)
            Text(description)
                .font(Font.Poppins(weight: 600, size: 15))
                .foregroundColor(Color.weather.textPrimary)
        }
        .padding()
    }
}

#Preview {
    let viewModel = HomeViewModel()
    HomeEmptyView(
        title: viewModel.emptyTitle,
        description: viewModel.emptyDescription
    )
}
