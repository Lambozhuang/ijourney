//
//  CityServiceIntegrationTests.swift
//  ijourneyTests
//
//  Created by LamboZhuang on 2024-05-22.
//

import XCTest
@testable import ijourney

final class CityServiceIntegrationTests: XCTestCase {

  var service: CityService!
  
  override func setUp() {
    super.setUp()
    
    service = CityService()
    
  }
  
  func testFetchItinerarySuccess() async throws {
    
    let city = City(name: "Paris", countryCode: "FR", countryName: "France")
    
    do {
      let (latitude, longitude) = try await service.fetchCoordinates(for: city)
      
      print("latitude: \(latitude), longitude: \(longitude)")
      
      XCTAssertEqual(latitude, 48.856666666, accuracy: 0.000001)
      XCTAssertEqual(longitude, 2.352222222, accuracy: 0.000001)
    } catch {
      XCTFail("Failed to fetch itinerary: \(error)")
    }
  }

}
