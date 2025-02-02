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

/// Note: There are many ways to hold strings in the project.
/// Strings catalog with manager injected as dependency is the best approach in my opition, but
/// I decided to keep demo project simple as possible.
struct HomeViewModelStrings {
    static let emptyTitle = "No City Selected"
    static let emptyDescription = "Please Search For a City"
    static let searchPlaceholderText = "Search Location"
    static let errorTitle = "Error"
    static let errorDescription = "Please, try again later."
    static let noconnectionTitle = "No Internet Connection"
}

final class HomeViewModel: ObservableObject {
    
    @Dependency var weatherApiManager: WeatherApiManagable?
    @Dependency var persistenceManager: PersistenceManagable?
    @Dependency var connectionManager: ConnectionManagable?
    
    let searchTextPublisher = PassthroughSubject<String, Never>()
    
    var cancellables = Set<AnyCancellable>()
    var emptyTitle: String { HomeViewModelStrings.emptyTitle }
    var emptyDescription: String { HomeViewModelStrings.emptyDescription }
    var searchPlaceholderText: String { HomeViewModelStrings.searchPlaceholderText}
    
    @Published var state: HomeState = .empty
    @Published var searchText = ""
    @Published var weather: Weather?
    @Published var searchResults: [Search] = []
    @Published var errorText: String = ""
    @Published var errorDescription: String = ""
    
    var weatherImageUrl: URL? {
        getUrlFrom(string: weather?.current?.condition?.icon)
    }
    
    init() {
        subscribeToSearchText()
        subscribeToConnectionManager()
        checkForSavedLocation()
    }
    
    /// Initializer added for mocking and testing purposes
    internal init(searchResults: [Search]) {
        self.searchResults = searchResults
    }
    
}


// MARK: - Subscriptions
extension HomeViewModel {
    
    /// Subscribe to search text input chage.
    private func subscribeToSearchText() {
        searchTextPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] newValue in
                if !newValue.isEmpty && newValue.count > 2 {
                    Task {
                        await self?.fetchSearch(for: newValue)
                    }
                }
                if newValue.isEmpty {
                    self?.searchResults = []
                    Task {
                        await self?.reset()
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    /// Subscribe to connection manager.
    private func subscribeToConnectionManager() {
        connectionManager?.connectionPublisher.sink { [weak self] value in
            if value {
                Task {
                    if self?.state == .error {
                        await self?.reset()
                    }
                }
            } else {
                Task {
                    await self?.setError(
                        title: HomeViewModelStrings.noconnectionTitle,
                        description: HomeViewModelStrings.errorDescription
                    )
                }
            }
        }
            .store(in: &cancellables)
    }
    
}


// MARK: - Public methods
extension HomeViewModel {
    
    /// Search result tap handler
    /// - Parameters:
    ///   - name: Location name.
    ///   - region: Location region.
    func didTapLocation(name: String, region: String) {
        searchText = ""
        Task {
            await fetchWeather(for: name, region: region)
            persistenceManager?.saveLocation(for: name, region: region)
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
    
}


// MARK: - Private methods
extension HomeViewModel {

    /// Fetch weather for location.
    private func fetchWeather(for value: String, region: String? = nil) async {
        var name = value
        if let region {
            name += ", \(region)"
        }
        await MainActor.run {
            state = .loading(useCase: .weather)
        }
        do {
            guard let currentWeather = try await weatherApiManager?.fetchCurrentWeather(for: name) else {
                await setNetworkError()
                return
            }
            await MainActor.run {
                state = .loaded(useCase: .weather)
                weather = currentWeather
            }
        } catch {
            await setNetworkError()
        }
    }
    
    /// Fetch location search.
    private func fetchSearch(for query: String) async {
        await MainActor.run {
            state = .loading(useCase: .search)
        }
        do {
            guard let results = try await weatherApiManager?.fetchSearch(for: query) else {
                await setNetworkError()
                return
            }
            await MainActor.run {
                state = .loaded(useCase: .search)
                searchResults = results
            }
            await self.fetchWeatherForSearchResults()
        } catch {
            await setNetworkError()
        }
    }
    
    /// Fetch weather for every search result.
    private func fetchWeatherForSearchResults() async {
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

    /// Reset state to weather if data exists, or to empty.
    @MainActor private func reset() {
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
  
    /// Set network error.
    @MainActor private func setNetworkError() {
        setError(
            title: HomeViewModelStrings.errorTitle,
            description: HomeViewModelStrings.errorDescription
        )
    }
    
    /// Set error state and add error text and description.
    /// - Parameters:
    ///   - text: Error text.
    ///   - description: Error description.
    @MainActor private func setError(title: String, description: String) {
        state = .error
        errorText = title
        errorDescription = description
    }
    
}
