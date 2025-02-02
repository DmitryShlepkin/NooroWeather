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
    @Dependency var persistenceManager: PersistenceManagable?
    
    var state: HomeState = .empty
    var cancellables = Set<AnyCancellable>()
    
    let searchTextPublisher = PassthroughSubject<String, Never>()
    let emptyTitle = "No City Selected"
    let emptyDescription = "Please Search For a City"
    let searchPlaceholderText: String = "Search Location"
    
    @Published var searchText: String = ""
    @Published var weather: Weather?
    @Published var searchResults: [Search] = []
    @Published var errorText: String = ""
    @Published var errorDescription: String = ""
    
    var weatherImageUrl: URL? {
        getUrlFrom(string: weather?.current?.condition?.icon)
    }
    
    init() {
        subscribeToSearchText()
        checkForSavedLocation()
    }
    
    /// Initializer added for mocking and testing purposes
    internal init(searchResults: [Search]) {
        self.searchResults = searchResults
    }
    
    /// Subscribe to Search Text Input chage.
    private func subscribeToSearchText() {
        searchTextPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] newValue in
                if !newValue.isEmpty && newValue.count > 2 {
                    Task {
                        await self?.fetchSearch(for: newValue)
                    }
                } else {
                    Task {
                        await self?.resetSearch()
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    /// Fetch weather for location.
    private func fetchWeather(for value: String, region: String? = nil) async {
        var name = value
        if let region {
            name += ", \(region)"
        }
        state = .loading(useCase: .weather)
        do {
            guard let weather = try await weatherApiManager?.fetchCurrentWeather(for: name) else {
                await setNetworkError()
                return
            }
            state = .loaded(useCase: .weather)
            await MainActor.run {
                self.weather = weather
            }
        } catch {
            await setNetworkError()
        }
    }
    
    /// Fetch location search.
    private func fetchSearch(for query: String) async {
        state = .loading(useCase: .search)
        do {
            guard let searchResults = try await weatherApiManager?.fetchSearch(for: query) else {
                await setNetworkError()
                return
            }
            state = .loaded(useCase: .search)
            await MainActor.run {
                self.searchResults = searchResults
            }
            await self.fetchWeatherForSearchResults()
        } catch {
            await setNetworkError()
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
            var icon: String? = nil
            if let weatherForItem {
                temperature = weatherForItem?.current?.temp_c
                icon = weatherForItem?.current?.condition?.icon
            }
            return Search(
                id: item.id,
                name: item.name,
                region: item.region,
                temp_c: temperature,
                icon: icon
            )
        }
        await MainActor.run {
            searchResults = updateSearchResults
        }
    }

    /// Search result tap handler
    /// - Parameters:
    ///   - name: Location name.
    ///   - region: Location region.
    func didTapLocation(name: String, region: String) {
        Task {
            await fetchWeather(for: name, region: region)
            await resetSearchText()
            persistenceManager?.saveLocation(for: name, region: region)
        }
    }

    /// Reset search text input value.
    @MainActor func resetSearchText() {
        searchText = ""
    }
    
    /// Reset search
    @MainActor private func resetSearch() {
        resetSearchText()
        searchResults = []
        if weather != nil {
            state = .loaded(useCase: .weather)
        } else {
            state = .empty
        }
    }
    
    /// Check for saved location in persistence container.
    private func checkForSavedLocation() {
        guard
            let location = persistenceManager?.loadLocation(),
            let name = location.name else {
            return
        }
        Task {
            await fetchWeather(for: name, region: location.region)
        }
    }
  
    /// Convert string to URL, convert icon size from 64x64 to 128x128, add https protocol to URL.
    /// - Parameters:
    ///   - string: URL string.
    /// - Returns: URL with https protocol and updated icon size.
    func getUrlFrom(string urlString: String?) -> URL? {
        guard var urlString else { return nil }
        urlString = urlString.replacingOccurrences(of: "64x64", with: "128x128")
        return URL(string: "https:\(urlString)")
    }
    
    /// Set network error.
    @MainActor private func setNetworkError() {
        setError(text: "Error", description: "Please, try again later.")
    }
    
    /// Set error state and add error text and description.
    /// - Parameters:
    ///   - text: Error text.
    ///   - description: Error description.
    @MainActor private func setError(text: String, description: String) {
        state = .error
        errorText = text
        errorDescription = description
    }
    
}
