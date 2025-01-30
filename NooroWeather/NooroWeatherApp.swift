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
            HomeView(viewModel: HomeViewModel())
        }
    }
    
    private func registerDependencies() {
        DependencyContainer.register(type: NetworkManagable.self, NetworkManager())
    }
    
}
