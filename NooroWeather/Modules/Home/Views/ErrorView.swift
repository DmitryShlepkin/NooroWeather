//
//  ErrorView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/31/25.
//

import SwiftUI

struct ErrorView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.errorText)
                .frame(height: 45)
                .font(Font.Poppins(weight: 600, size: 30))
                .foregroundColor(Color.weather.textPrimary)
                .padding(8)
            Text(viewModel.errorDescription)
                .font(Font.Poppins(size: 15))
                .foregroundColor(Color.weather.textPrimary)
        }
        .padding()
    }
}
