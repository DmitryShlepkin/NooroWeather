//
//  HomeViewModelTests.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/2/25.
//

import Testing
@testable import NooroWeather

@Suite("HomeViewModel")
struct HomeViewModelTests {

    @Test("getUrlFrom") func testGetUrlFrom_givenInputUrlStringWithoutProtocol_expectStringWithHttps() async throws {
        let sut = HomeViewModel()
        let expectation = "https://test/test.png"
        let url = sut.getUrlFrom(string: "//test/test.png")
        #expect(url?.absoluteString == expectation)
    }
    
    @Test("getUrlFrom icon conversion") func testGetUrlFrom_givenInputUrlStringWithIconX64_expectFormattedStringWithIconx128() async throws {
        let sut = HomeViewModel()
        let expectation = "https://test/128x128/test.png"
        let url = sut.getUrlFrom(string: "//test/64x64/test.png")
        #expect(url?.absoluteString == expectation)
    }
    
    @Test("didTapLocation") func testDidTapLocation_givenTap_expectSearchTextToBeEmptyAndPersistenceManagerCalled() async throws {
        let mockPersistenceManager = MockPersistenceManager()
        DependencyContainer.register(type: PersistenceManagable.self, mockPersistenceManager, update: true)
        let sut = HomeViewModel()
        sut.searchText = "test"
        sut.didTapLocation(name: "TestName", region: "TestRegion")
        try await Task.sleep(for: .seconds(2))
        #expect(sut.searchText == "")
        #expect(mockPersistenceManager.isSaveLocationCalled == true)
        #expect(mockPersistenceManager.location == "TestName")
        #expect(mockPersistenceManager.region == "TestRegion")
    }
        
    @Test("searchResults") func testSearchResults_givenEmptySearchText_expectSearchResultsCountToBe0() async throws {
        let sut = HomeViewModel()
        sut.searchTextPublisher.send("")
        #expect(sut.searchResults.count == 0)
    }
    
}
