//
//  HomeView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct HomeView: View {
        
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            SearchInputView(
                searchText: $viewModel.searchText,
                placeholderText: viewModel.searchPlaceholderText
            )
            VStack(spacing: 0) {
                Spacer()
                    .visible(viewModel.state == .empty || viewModel.state == .error)
                ErrorView()
                    .visible(viewModel.state == .error)
                HomeEmptyView(
                    title: viewModel.emptyTitle,
                    description: viewModel.emptyDescription
                )
                    .visible(viewModel.state == .empty)
                WeatherView()
                    .visible(viewModel.state == .loaded(useCase: .weather))
                    .padding(.top, 50)
                SearchResultsView()
                    .visible(viewModel.state == .loaded(useCase: .search))
                Spacer()
            }
                .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
