//
//  Color+Extension.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUI

/// Note: There are many ways to hold colors in the project: from design library to local entities with color.
/// I decided to keep demo project simple as possible and keep declarative approach at the same time.
/// Example: Color.weather.textPrimary or Color.weather.backgroundPrimary

struct WeatherColors {
    let textPrimary: Color = .init(hex: "#2C2C2C")
    let textSecondary: Color = .init(hex: "#C4C4C4")
    let textMediumGray: Color = .init(hex: "#9A9A9A")
    let backgroundPrimary: Color = .init(hex: "#F2F2F2")
    let backgroundSecondary: Color = .init(hex: "#DEDEDE")
}

extension Color {
    
    init(hex: String, alpha: CGFloat = 1.0) {
        var trimmedString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if trimmedString.hasPrefix("#") {
            trimmedString.remove(at: trimmedString.startIndex)
        }
        if trimmedString.count != 6 {
            self.init(
                .sRGB,
                red: 0,
                green: 0,
                blue: 0,
                opacity: 1
            )
        }
        var rgbValue: UInt64 = 0
        Scanner(string: trimmedString).scanHexInt64(&rgbValue)
        self.init(
            .sRGB,
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
    
    static let weather = WeatherColors()
    
}
