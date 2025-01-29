//
//  Font+Extension.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/29/25.
//

import SwiftUICore

extension Font {

    /// Note: There are many ways to add custom fonts to the project: from design library to
    /// generic extension which can handle any custom font.
    /// However I noticed that figma project contains same font name and different weights.
    /// In order to speak same language with design team and not to overcomplicate this demo project I decided to
    /// extened Font with variable which contains font name to keep it simple and declarative.
    /// Example: Font.Poppins(size: 30) or Font.Poppins(weight: 600, size: 30)

    /// Provide custom font named Poppins.
    /// - Parameters:
    ///   - weight: Used to determine font name.
    ///   - size: Font size.
    /// - Returns: Custom `Font` with passed params.
    static func Poppins(weight: Int = 400, size: CGFloat) -> Font {
        var fontName: String = "Poppins-Regular"
        switch weight {
        case 100:
            fontName = "Poppins-Thin"
        case 200:
            fontName = "Poppins-ExtraLight"
        case 300:
            fontName = "Poppins-Light"
        case 400:
            fontName = "Poppins-Regular"
        case 500:
            fontName = "Poppins-Medium"
        case 600:
            fontName = "Poppins-SemiBold"
        case 700:
            fontName = "Poppins-Bold"
        default:
            fontName = "Poppins-Regular"
        }
        return Font.custom(fontName, size: size)
    }

}
