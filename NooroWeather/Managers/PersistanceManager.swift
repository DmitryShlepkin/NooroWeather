//
//  PersistanceManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/31/25.
//

import Foundation

protocol PersistenceManagable {
    func loadLocation() -> (name: String?, region: String?)
    func saveLocation (for location: String, region: String?)
}

final class PersistenceManager: PersistenceManagable {
    
    private let defaults = UserDefaults.standard
    
    /// Load location name and region from UserDefaults.
    /// - Returns: Tuple with location name and region.
    func loadLocation() -> (name: String?, region: String?) {
        if
            let location = defaults.string(forKey: "Location"),
            let region = defaults.string(forKey: "Region") {
            return (location, region)
        }
        return (nil, nil)
    }

    /// Save location name and region to UserDefaults.
    /// - Parameters:
    ///   - for: Location name.
    ///   - region: Region.
    func saveLocation (for location: String, region: String?) {
        defaults.set(location, forKey: "Location")
        if let region {
            defaults.set(region, forKey: "Region")
        }
    }
}
