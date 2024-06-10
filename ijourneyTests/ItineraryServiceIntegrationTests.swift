//
//  ItineraryServiceIntegrationTests.swift
//  ItineraryServiceTests
//
//  Created by LamboZhuang on 2024-05-21.
//

import XCTest
@testable import ijourney

final class ItineraryServiceIntegrationTests: XCTestCase {

  var service: ItineraryService!
  
  override func setUp() {
    super.setUp()
    
    service = ItineraryService()
    
  }
  
  func testFetchItinerarySuccess() async throws {
    
    let sampleCity = City(name: "Rome", countryCode: "IT", countryName: "Italy")
    
    var sampleInterests = Interests()
    sampleInterests[.historical] = .veryHigh
    sampleInterests[.cultural] = .high
    sampleInterests[.nature] = .low
    
    let userPrompt = service.composeUserPrompt(city: sampleCity, startDate: Date(), endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, interests: sampleInterests)
    
    do {
      let itinerary = try await service.fetchItinerary(userPrompt: userPrompt)

      print(itinerary)

      XCTAssertEqual(itinerary.cityName, "Rome")
      XCTAssertEqual(itinerary.countryName, "Italy")
      XCTAssertEqual(itinerary.days.count, 4)
    } catch {
      XCTFail("Failed to fetch itinerary: \(error)")
    }
  }

}
