//
//  SearchResultsView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct SearchResultsView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("Mumbai")
                    .frame(height: 30)
                    .padding(.bottom, 12)
                    .font(Font.Poppins(weight: 600, size: 20))
                    .foregroundColor(Color.weather.textPrimary)
                    .lineSpacing(0)
                    .lineLimit(1)
                ZStack(alignment: .topTrailing) {
                    Text("20")
                        .frame(height: 42)
                        .font(Font.Poppins(weight: 500, size: 60))
                        .foregroundColor(Color.weather.textPrimary)
                        .lineLimit(1)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 8))
                    Image("icon.degree")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            Spacer()
            Image("image.weather.sun")
                .resizable()
                .frame(width: 84, height: 84)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
            .padding(.init(top: 16, leading: 30, bottom: 16, trailing: 30))
            .background(Color.weather.backgroundPrimary)
            .cornerRadius(16)
            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
        Spacer()
    }
}

#Preview {
    SearchResultsView()
}
