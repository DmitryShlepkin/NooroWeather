//
//  WeatherView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("image.weather.sun")
                .frame(width: 123, height: 123)
                .padding(.init(top: 0, leading: 0, bottom: 16, trailing: 0))
            HStack {
                Text("Mumbai")
                    .font(Font.Poppins(weight: 600, size: 30))
                    .foregroundColor(Color.weather.textPrimary)
                    .lineLimit(1)
                Image("icon.location")
                    .frame(width: 21, height: 21)
            }
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            HStack {
                ZStack(alignment: .topTrailing) {
                    Text("45")
                        .font(Font.Poppins(weight: 500, size: 70))
                        .foregroundColor(Color.weather.textPrimary)
                        .lineSpacing(20)
                        .lineLimit(1)
                        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Image("icon.degree")
                        .frame(width: 8, height: 8)
                        .padding(.init(top: 12, leading: 0, bottom: 0, trailing: 0))
                }
            }
            WeatherStatsView()
                .padding(.init(top: 32, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

#Preview {
    WeatherView()
}
