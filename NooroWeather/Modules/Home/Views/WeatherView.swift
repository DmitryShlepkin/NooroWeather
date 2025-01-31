//
//  WeatherView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image("image.weather.sun")
                .resizable()
                .frame(width: 123, height: 123)
                .padding(.bottom, 27)
            HStack {
                Text(viewModel.weather?.location?.name ?? "")
                    .frame(height: 30)
                    .font(Font.Poppins(weight: 600, size: 30))
                    .foregroundColor(Color.weather.textPrimary)
                    .lineLimit(1)
                Image("icon.location")
                    .resizable()
                    .frame(width: 21, height: 21)
            }
                .padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
            HStack {
                ZStack(alignment: .topTrailing) {
                    Text("\(Int(viewModel.weather?.current?.temp_c ?? 0))")
                        .frame(height: 70)
                        .font(Font.Poppins(weight: 500, size: 70))
                        .foregroundColor(Color.weather.textPrimary)
                        .lineSpacing(20)
                        .lineLimit(1)
                        .padding([.leading, .trailing], 16)
                    Image("icon.degree")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .padding(0)
                }
            }
            WeatherStatsView()
                .padding(.top, 36)
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(HomeViewModel())
}
