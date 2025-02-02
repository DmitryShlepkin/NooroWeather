//
//  WeatherApiManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

import Foundation

protocol WeatherApiManagable {
    func fetchCurrentWeather(for: String) async throws -> Weather?
    func fetchSearch(for: String) async throws -> [Search]?
}

final class WeatherApiManager: WeatherApiManagable {
    
    @Dependency var configurationManager: ConfigurationManagable?
    @Dependency var networkManager: NetworkManagable?
    
    private var host = "https://api.weatherapi.com/v1"
    private var APIKey: String?
    
    init() {
        APIKey = configurationManager?.getValueFromInfo(for: "WEATHER_API_KEY")
    }
        
    func fetchCurrentWeather(for queryString: String) async throws -> Weather? {
        guard let APIKey else {
            return nil
        }
        do {
            return try await networkManager?.request(
                url: "\(host)/current.json",
                parameters: [
                    "key": APIKey,
                    "q": queryString,
                    "aqi": "no"
                ],
                as: Weather.self
            )
        } catch {
            throw error
        }
    }
    
    func fetchSearch(for queryString: String) async throws -> [Search]? {
        guard let APIKey else {
            return nil
        }
        do {
            return try await networkManager?.request(
                url: "\(host)/search.json",
                parameters: [
                    "key": APIKey,
                    "q": queryString
                ],
                as: [Search].self
            )
        } catch {
            throw error
        }
    }
    
}
