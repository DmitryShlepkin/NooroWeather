//
//  HomeView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            SearchInputView(
                searchText: $viewModel.searchText,
                placeholderText: viewModel.searchPlaceholderText
            )
            VStack(spacing: 0) {
//                Spacer()
//                HomeEmptyView(
//                    title: viewModel.emptyTitle,
//                    description: viewModel.emptyDescription
//                )
                WeatherView()
                    .padding(.top, 50)
//                SearchResultsView()
                Spacer()
            }
                .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
