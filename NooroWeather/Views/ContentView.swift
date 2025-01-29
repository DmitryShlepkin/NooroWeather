//
//  ContentView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SearchInputView(cityName: "")
            Group {
                EmptyView()
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
