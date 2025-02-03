//
//  SearchResultsSkeleton.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/2/25.
//

import SwiftUI

struct SearchResultsSkeletonView: View {
    var body: some View {
        VStack(spacing: 12) {
            ForEach((1...3), id: \.self) { _ in
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("")
                            .frame(
                                width: 300,
                                height: 12,
                                alignment: .leading
                            )
                            .background(Color.weather.backgroundSecondary)
                        Text("")
                            .frame(
                                width: 200,
                                height: 12,
                                alignment: .leading
                            )
                            .padding(0)
                            .background(Color.weather.backgroundSecondary)
                        Text("")
                            .frame(
                                width: 100,
                                height: 12,
                                alignment: .leading
                            )
                            .background(Color.weather.backgroundSecondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(32)
                .background(Color.weather.backgroundPrimary)
                .cornerRadius(16)
                .padding([.leading, .trailing], 16)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SearchResultsSkeletonView()
}
