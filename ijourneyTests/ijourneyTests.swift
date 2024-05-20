//
//  ijourneyTests.swift
//  ijourneyTests
//
//  Created by LamboZhuang on 2024-05-01.
//

import XCTest
@testable import ijourney

final class ijourneyTests: XCTestCase {

  func testItineraryJSONDecodesItineraryJSON() throws {
    
    guard let url = Bundle.main.url(forResource: "example-itinerary-1", withExtension: "json") else {
      return
    }
    
    let data = try Data(contentsOf: url)
    
    let decoder = JSONDecoder()
    let decoded = try decoder.decode(Itinerary.self, from: data)
    
    XCTAssertEqual(decoded.days.count, 3)
    XCTAssertEqual(decoded.days[0].pointOfInterestList.count, 3)
  }
  
  func testClientDoesFetchNewItineraryData() async throws {
    let networkService = TestNetworkService()
    let client = ItineraryClient(networkService: networkService)
    let itinerary = try await client.fetchItinerary(systemPrompt: "", userPrompt: "")
    
    XCTAssertEqual(itinerary.days.count, 3)
  }

}
