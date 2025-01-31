//
//  WeatherApiManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

protocol WeatherApiManagable {
    func fetchCurrentWeather(for: String) async -> Weather?
}

final class WeatherApiManager: WeatherApiManagable {
    
    @Dependency var configurationManager: ConfigurationManagable?
    @Dependency var networkManager: NetworkManagable?
    
    func fetchCurrentWeather(for queryString: String) async -> Weather? {
        guard let APIKey = configurationManager?.getValueFromInfo(for: "WEATHER_API_KEY") else {
            return nil
        }
        do {
            return try await networkManager?.request(
                url: "https://api.weatherapi.com/v1/current.json",
                parameters: [
                    "key": APIKey,
                    "q": queryString,
                    "aqi": "no"
                ],
                as: Weather.self
            )
        } catch {
            return nil
        }
    }
    
}
