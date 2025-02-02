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
                .environmentObject(HomeViewModel())
        }
    }
    
    private func registerDependencies() {
        DependencyContainer.register(type: NetworkManagable.self, NetworkManager())
        DependencyContainer.register(type: ConfigurationManagable.self, ConfigurationManager())
        DependencyContainer.register(type: WeatherApiManagable.self, WeatherApiManager())
        DependencyContainer.register(type: PersistenceManagable.self, PersistenceManager())
        DependencyContainer.register(type: ConnectionManagable.self, ConnectionManager())
    }
    
}
