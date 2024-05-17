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
    
    let decoder = JSONDecoder()
    let decoded = try decoder.decode(Itinerary.self, from: testItineraryData)
    
    XCTAssertEqual(decoded.days.count, 3)
    XCTAssertEqual(decoded.days[0].pointOfInterestList.count, 3)
  }
  
  func testClientDoesFetchNewItineraryData() async throws {
    let downloader = TestDownloader()
    let client = ItineraryClient(downloader: downloader)
    let itinerary = try await client.itinerary
    
    XCTAssertEqual(itinerary.days.count, 3)
  }

}
