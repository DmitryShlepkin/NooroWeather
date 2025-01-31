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
    
    /// Initializer added for mocking and testing purposes
    internal init(searchResults: [Search]) {
        self.searchResults = searchResults
    }
    
    /// Subscribe to Search Text Input chage.
    private func subscribeToSearchText() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                print(value)
                if !value.isEmpty && value.count > 2 {
                    Task {
                        await self?.fetchSearch(for: value)
                    }
                } else {
                    print("Reset Search")
                }
            })
            .store(in: &cancellables)
    }
    
    /// Fetch weather for location.
    private func fetchWeather(for value: String, region: String? = nil) async {
        state = .loading(useCase: .weather)
        do {
            guard let weather = try await weatherApiManager?.fetchCurrentWeather(for: "Columbus") else {
                state = .error
                return
            }
            state = .loaded(useCase: .weather)
            await MainActor.run {
                self.weather = weather
            }
        } catch {
            state = .error
        }
    }
    
    /// Fetch location search.
    private func fetchSearch(for query: String) async {
        state = .loading(useCase: .search)
        do {
            guard let searchResults = try await weatherApiManager?.fetchSearch(for: query) else {
                state = .error
                return
            }
            state = .loaded(useCase: .search)
            await MainActor.run {
                self.searchResults = searchResults
            }
            await self.fetchWeatherForSearchResults()
        } catch {
            state = .error
        }
    }
    
    /// Fetch weather for every search result.
    func fetchWeatherForSearchResults() async {
        let weatherResults: [Weather?] = await withTaskGroup(
            of: Weather?.self,
            returning: [Weather?].self
        ) { [self] group in
            var weather: [Weather?] = []
            for item in self.searchResults {
                if var name = item.name {
                    if let region = item.region {
                        name += ", \(region)"
                    }
                    group.addTask {
                        return try? await self.weatherApiManager?.fetchCurrentWeather(for: name)
                    }
                }
            }
            for await result in group {
                weather.append(result)
            }
            return weather
        }
        await updateSearchResults(with: weatherResults)
    }
    
    /// Update search results with weather if possible.
    private func updateSearchResults(with weatherResults: [Weather?]) async {
        let updateSearchResults = searchResults.map { item in
            let weatherForItem = weatherResults.first(where: { $0?.location?.name == item.name && $0?.location?.region == item.region })
            var temperature: Double? = nil
            if let weatherForItem {
                temperature = weatherForItem?.current?.temp_c
            }
            return Search(
                id: item.id,
                name: item.name,
                region: item.region,
                temp_c: temperature
            )
        }
        await MainActor.run {
            searchResults = updateSearchResults
        }
    }
    
    /// Search result tap handler
    func didTapLocation(name: String, region: String) {
        print("didTapLocation", name, region)
    }
    
}
