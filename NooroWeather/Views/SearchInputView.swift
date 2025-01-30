//
//  SearchInputView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct SearchInputView: View {
    
    @State var cityName: String
    
    var body: some View {
        HStack {
            HStack {
                TextField(
                    "",
                    text: $cityName,
                    prompt: Text("Search Location").foregroundColor(Color.weather.textSecondary)
                )
                    .foregroundColor(Color.weather.textPrimary)
                Image("icon.search")
            }
            .frame(height: 14)
            .padding(16)
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(16)
            .font(Font.Poppins(size: 15))
        }
        .padding(24)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchInputView(cityName: "")
}
