//
//  View+Extension.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

import Foundation
import SwiftUI

extension View {
    func visible(_ isVisible: Bool) -> some View {
        modifier(VisibleModifier(isVisible: isVisible))
    }
}

fileprivate struct VisibleModifier: ViewModifier {
    let isVisible: Bool
    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                EmptyView()
            }
        }
    }
}
