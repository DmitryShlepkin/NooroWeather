//
//  MockConnectionManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Combine
@testable import NooroWeather

class MockConnectionManager: ConnectionManagable {
    let connectionPublisher = PassthroughSubject<Bool, Never>()
    var isConnected = false
}
