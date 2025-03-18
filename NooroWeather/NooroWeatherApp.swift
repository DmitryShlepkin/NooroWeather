//
//  NooroWeatherApp.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

@main
struct NooroWeatherApp: App {
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
        }
    }
    
    private func registerDependencies() {
        DependencyManager.register(type: NetworkManagable.self, NetworkManager())
        DependencyManager.register(type: ConfigurationManagable.self, ConfigurationManager())
        DependencyManager.register(type: WeatherApiManagable.self, WeatherApiManager())
        DependencyManager.register(type: PersistenceManagable.self, PersistenceManager())
        DependencyManager.register(type: ConnectionManagable.self, ConnectionManager())
    }
    
}
