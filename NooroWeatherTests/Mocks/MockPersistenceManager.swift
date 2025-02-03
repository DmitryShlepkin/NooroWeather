//
//  MockPersistenceManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

@testable import NooroWeather

class MockPersistenceManager: PersistenceManagable {
    
    var isLoadLocationCalled = false
    var isSaveLocationCalled = false
    
    var location: String? = nil
    var region: String? = nil
    
    func loadLocation() -> (name: String?, region: String?) {
        isLoadLocationCalled = true
        return (location, region)
    }
    
    func saveLocation(for location: String, region: String?) {
        isSaveLocationCalled = true
        self.location = location
        guard let region else { return }
        self.region = region
    }
       
}
