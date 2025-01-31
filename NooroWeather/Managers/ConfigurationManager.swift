//
//  ConfigurationManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

import Foundation

protocol ConfigurationManagable {
    func getValueFromInfo(for key: String) -> String?
}

final class ConfigurationManager: ConfigurationManagable {
    
    /// Reads value from info dictionary.
    /// - Parameters:
    ///   - for: key in the info dictionary.
    /// - Returns: value for key from info dictionary.
    func getValueFromInfo(for key: String) -> String? {
        guard let value = Bundle.main.infoDictionary?[key] as? String else { return nil }
        return value
    }
    
}
