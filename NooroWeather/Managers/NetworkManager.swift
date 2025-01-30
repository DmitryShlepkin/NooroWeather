//
//  NetworkManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 1/30/25.
//

protocol NetworkManagable {
    func request()
}

final class NetworkManager: NetworkManagable {
    
    func request() {
        print("request")
    }
        
}
