//
//  HomeViewModel.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import Combine
import Foundation

enum HomeUseCase {
    case weather
    case search
}

enum HomeState {
    case loading(useCase: HomeUseCase)
    case loaded(useCase: HomeUseCase)
    case empty
    case error
}

final class HomeViewModel: ObservableObject {
    
    var state: HomeState = .empty
    var cancellables = Set<AnyCancellable>()
    
    let emptyTitle = "No City Selected"
    let emptyDescription = "Please Search For a City"
        
    @Published var searchText: String = ""
    let searchPlaceholderText: String = "Search Location"
    
    init() {
        subscribeToSearchText()
    }
    
    private func subscribeToSearchText() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                print(value)
            })
            .store(in: &cancellables)
    }
    
}
