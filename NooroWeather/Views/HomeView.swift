//
//  ContentView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            SearchInputView(cityName: "")
            VStack {
//                EmptyView()
//                WeatherView()
                SearchResultsView()
            }
                .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeView()
}
