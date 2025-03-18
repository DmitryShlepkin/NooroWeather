//
//  HomeView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct HomeView: View {
        
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            SearchInputView(viewModel: viewModel)
            VStack(spacing: 0) {
                Spacer()
                    .visible(
                        viewModel.state == .empty ||
                        viewModel.state == .error
                    )
                ErrorView(viewModel: viewModel)
                    .visible(viewModel.state == .error)
                HomeEmptyView(
                    title: viewModel.emptyTitle,
                    description: viewModel.emptyDescription
                )
                    .visible(viewModel.state == .empty)
                WeatherView(viewModel: viewModel)
                    .visible(viewModel.state == .loading(useCase: .weather) || viewModel.state == .loaded(useCase: .weather))
                    .redacted(reason: viewModel.state == .loading(useCase: .weather) ? .placeholder : [])
                    .padding(.top, 50)
                SearchResultsSkeletonView()
                    .visible(viewModel.state == .loading(useCase: .search))
                ScrollView(.vertical, showsIndicators: false) {
                    SearchResultsView(viewModel: viewModel)
                }
                    .visible(viewModel.state == .loaded(useCase: .search))
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .background(Color.white)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    HomeView()
}
