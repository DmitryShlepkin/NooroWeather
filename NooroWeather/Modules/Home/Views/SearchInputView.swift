//
//  SearchInputView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct SearchInputView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            HStack {
                TextField(
                    "",
                    text: $viewModel.searchText,
                    prompt: Text(viewModel.searchPlaceholderText).foregroundColor(Color.weather.textSecondary)
                )
                    .onChange(of: viewModel.searchText) { oldState, newState in
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
    SearchInputView(viewModel: HomeViewModel())
}
