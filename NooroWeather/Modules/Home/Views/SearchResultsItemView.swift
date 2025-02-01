//
//  SearchResultsItemView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/31/25.
//

import SwiftUI

struct SearchResultsItemView: View {

    let name: String
    let temp_c: Double?
    let iconUrl: URL?
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(name)
                    .frame(height: 30)
                    .padding(.bottom, 12)
                    .font(Font.Poppins(weight: 600, size: 20))
                    .foregroundColor(Color.weather.textPrimary)
                    .lineSpacing(0)
                    .lineLimit(1)
                ZStack(alignment: .topTrailing) {
                    Text("\(Int(temp_c ?? 0))")
                        .frame(height: 42)
                        .font(Font.Poppins(weight: 500, size: 60))
                        .foregroundColor(Color.weather.textPrimary)
                        .lineLimit(1)
                        .padding(.trailing, 8)
                        .visible(temp_c != nil)
                    Image("icon.degree")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .padding(0)
                        .visible(temp_c != nil)
                    Text("N/A")
                        .frame(height: 42)
                        .font(Font.Poppins(weight: 400, size: 16))
                        .foregroundColor(Color.weather.textSecondary)
                        .lineLimit(1)
                        .visible(temp_c == nil)
                }
                .frame(height: 42)
            }
            Spacer()
            AsyncImage(url: iconUrl)
                { image in
                    image.resizable()
                }
                placeholder: {
                    Color.weather.backgroundSecondary
                }
                .frame(width: 84, height: 84)
                .padding(0)
        }
            .padding(.init(top: 16, leading: 30, bottom: 16, trailing: 30))
            .background(Color.weather.backgroundPrimary)
            .cornerRadius(16)
            .padding([.leading, .trailing], 16)
    }
}
