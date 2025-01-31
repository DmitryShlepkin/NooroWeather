//
//  Search.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

struct Search: Codable, Hashable {
    let id: Int?
    let name: String?
    let region: String?
    var temp_c: Double?
}
