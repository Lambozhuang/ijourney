//
//  ItineraryServiceTests.swift
//  ijourneyTests
//
//  Created by LamboZhuang on 2024-05-21.
//

import XCTest
@testable import ijourney

final class ItineraryServiceTests: XCTestCase {

  func testServiceDoesFetchNewItineraryData() async throws {
    let networkService = TestNetworkService()
    let service = ItineraryService(networkService: networkService)
    let itinerary = try await service.fetchItinerary(userPrompt: "")
    
    XCTAssertEqual(itinerary.days.count, 4)
  }

}
