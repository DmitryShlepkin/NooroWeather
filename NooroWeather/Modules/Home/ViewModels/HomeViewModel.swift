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

enum HomeState: Equatable {
    case loading(useCase: HomeUseCase)
    case loaded(useCase: HomeUseCase)
    case empty
    case error
}

final class HomeViewModel: ObservableObject {
    
    @Dependency var weatherApiManager: WeatherApiManagable?
    
    var state: HomeState = .empty
    var cancellables = Set<AnyCancellable>()
    
    let emptyTitle = "No City Selected"
    let emptyDescription = "Please Search For a City"
        
    @Published var searchText: String = ""
    let searchPlaceholderText: String = "Search Location"
    
    @Published var weather: Weather?
    
    init() {
        subscribeToSearchText()
    }
    
    private func subscribeToSearchText() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                print(value)
                if !value.isEmpty && value.count > 3 {
                    Task {
                        await self?.fetchWeather()
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    private func fetchWeather() async {
        state = .loading(useCase: .weather)
        if let weather = await weatherApiManager?.fetchCurrentWeather(for: "Columbus") {
            state = .loaded(useCase: .weather)
            await MainActor.run {
                self.weather = weather
            }
        } else {
            state = .error
        }
    }
    
}
