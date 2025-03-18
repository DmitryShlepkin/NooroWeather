//
//  WeatherStatsView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct WeatherStatsView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            WeatherStatsItemView(
                label: "Humidity",
                value: "\(Int(viewModel.weather?.current?.humidity ?? 0))%"
            )
            WeatherStatsItemView(
                label: "UV",
                value: "\(Int(viewModel.weather?.current?.uv ?? 0))"
            )
            WeatherStatsItemView(
                label: "Feels Like",
                value: "\(Int(viewModel.weather?.current?.feelslike_c ?? 0))°"
            )
        }
        .frame(maxWidth: 254)
            .padding(16)
            .background(Color.weather.backgroundPrimary)
            .cornerRadius(16)
    }
}

#Preview {
    WeatherStatsView(viewModel: HomeViewModel())
}
