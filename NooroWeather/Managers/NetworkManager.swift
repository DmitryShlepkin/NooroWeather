//
//  NetworkManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

import Foundation

protocol NetworkManagable {
    func request<T:Codable>(url urlString: String, parameters: [String: String]?, as type: T.Type) async throws -> T?
}

final class NetworkManager: NetworkManagable {
        
    func request<T:Codable>(url urlString: String, parameters: [String: String]? = nil, as type: T.Type) async throws -> T? {
        
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
