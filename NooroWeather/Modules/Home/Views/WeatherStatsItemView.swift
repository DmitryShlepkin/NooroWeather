//
//  WeatherStatsItemView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct WeatherStatsItemView: View {
    
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(Font.Poppins(size: 12))
                .foregroundColor(Color.weather.textSecondary)
            Text(value)
                .font(Font.Poppins(weight: 500, size: 15))
                .foregroundColor(Color.weather.textMediumGray)
        }
            .frame(minWidth: 60)
    }
}

#Preview {
    WeatherStatsItemView(label: "Humidity", value: "20%")
}
