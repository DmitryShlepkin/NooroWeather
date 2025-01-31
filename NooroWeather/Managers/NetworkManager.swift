//
//  NetworkManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

import Foundation

protocol NetworkManagable {
    func fetchCurrentWeather(for: String) async -> Weather?
}

final class NetworkManager: NetworkManagable {
    
    @Dependency var configurationManager: ConfigurationManagable?
    
    func fetchCurrentWeather(for queryString: String) async -> Weather? {
        guard let APIKey = configurationManager?.getValueFromInfo(for: "WEATHER_API_KEY") else {
            return nil
        }
        print(">>>", APIKey)
        do {
            return try await request(
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
    
    private func request<T:Codable>(url urlString: String, parameters: [String: String]? = nil, as type: T.Type) async throws -> T? {
        
        var urlComponents = URLComponents(string: urlString)
        
        if let parameters {
            let queryItems: [URLQueryItem]? = parameters.keys.map { key in
                URLQueryItem(name: key, value: parameters[key])
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
            
}
