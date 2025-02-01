//
//  Weather.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

struct Location: Codable {
    let name: String?
    let region: String?
}

struct Current: Codable {
    let temp_c: Double?
    let humidity: Int?
    let feelslike_c: Double?
    let uv: Double?
    let condition: Condition?
}

struct Condition: Codable {
    let icon: String?
}

struct Weather: Codable {
    let location: Location?
    let current: Current?
}
