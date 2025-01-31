//
//  ErrorView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/31/25.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Error")
                .frame(height: 45)
                .font(Font.Poppins(weight: 600, size: 30))
                .foregroundColor(Color.weather.textPrimary)
                .padding(8)
            Text("Please try again later.")
                .font(Font.Poppins(size: 15))
                .foregroundColor(Color.weather.textPrimary)
        }
        .padding()
    }
}
