//
//  SearchResultsView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            SearchResultsEmptyView(viewModel: viewModel)
                .visible(viewModel.searchResults.count == 0)
            ForEach(viewModel.searchResults, id: \.self.id) { item in
                if let name = item.name {
                    SearchResultsItemView(
                        name: name,
                        temp_c: item.temp_c,
                        iconUrl: viewModel.getUrlFrom(string: item.icon)
                    )
                        .onTapGesture { view in
                            viewModel.didTapLocation(name: name, region: item.region ?? "")
                        }
                }
            }
                .visible(viewModel.searchResults.count > 0)
        }
    }
}

#Preview {
    SearchResultsView(viewModel: HomeViewModel(searchResults: [
        .init(id: 1, name: "Columbus", region: "Ohio", temp_c: nil),
        .init(id: 2, name: "Cleveland", region: "Ohio", temp_c: nil),
        .init(id: 3, name: "Cincinnati", region: "Ohio", temp_c: nil)
    ]))
}
