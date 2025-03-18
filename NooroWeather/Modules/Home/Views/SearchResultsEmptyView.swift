//
//  SearchResultsEmptyView.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/2/25.
//

import SwiftUI

///  No results found
///Try adjusting your search

struct SearchResultsEmptyView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 0) {
                Text(viewModel.searchEmptyTitle)
                    .font(Font.Poppins(size: 18))
                Text(viewModel.searchEmptyDescription)
                    .font(Font.Poppins(size: 13))
                    .foregroundColor(Color.weather.textMediumGray)
            }
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SearchResultsEmptyView(viewModel: HomeViewModel())
}
