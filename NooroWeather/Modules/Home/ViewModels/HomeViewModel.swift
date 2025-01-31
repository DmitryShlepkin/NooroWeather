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
    let searchPlaceholderText: String = "Search Location"
    
    @Published var searchText: String = ""
    @Published var weather: Weather?
    @Published var searchResults: [Search] = []
    
    init() {
        subscribeToSearchText()
    }
    
    private func subscribeToSearchText() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                print(value)
                if !value.isEmpty && value.count > 2{
                    Task {
//                        await self?.fetchSearch(for: value)
                        await self?.fetchWeather()
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    private func fetchWeather() async {
        state = .loading(useCase: .weather)
        do {
            guard let weather = try await weatherApiManager?.fetchCurrentWeather(for: "Columbus") else {
                state = .error
                return
            }
            state = .loaded(useCase: .weather)
            await MainActor.run {
                print(weather)
                self.weather = weather
            }
        } catch {
            print(">>>>> error")
            state = .error
        }
    }
    
    private func fetchSearch(for query: String) async {
        state = .loading(useCase: .search)
        print(">>>>", query)
        do {
            guard let searchResults = try await weatherApiManager?.fetchSearch(for: query) else {
                state = .error
                return
            }
            state = .loaded(useCase: .search)
            await MainActor.run {
                print(">>>>", searchResults)
                self.searchResults = searchResults
            }
        } catch {
            print(">>>>> error")
            state = .error
        }
    }
    
}
