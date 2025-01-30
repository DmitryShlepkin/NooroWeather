//
//  WeatherStatsView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct WeatherStatsView: View {
    var body: some View {
        HStack(spacing: 30) {
            WeatherStatsItemView(label: "Humidity", value: "20%")
            WeatherStatsItemView(label: "UV", value: "4")
            WeatherStatsItemView(label: "Feels Like", value: "38°")
        }
        .frame(maxWidth: 254)
            .padding(16)
            .background(Color.weather.backgroundPrimary)
            .cornerRadius(16)
    }
}

#Preview {
    WeatherStatsView()
}
