//
//  SearchInputView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct SearchInputView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var searchText: String
    let placeholderText: String
    
    var body: some View {
        HStack {
            HStack {
                TextField(
                    "",
                    text: $searchText,
                    prompt: Text(placeholderText).foregroundColor(Color.weather.textSecondary)
                )
                    .onChange(of: searchText) { oldState, newState in
                        viewModel.searchTextPublisher.send(newState)
                    }
                    .foregroundColor(Color.weather.textPrimary)
                    .autocorrectionDisabled(true)
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
    @ObservedObject var viewModel = HomeViewModel()
    SearchInputView(
        searchText: $viewModel.searchText,
        placeholderText: viewModel.searchPlaceholderText
    )
}
