//
//  TestNetworkService.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

class TestNetworkService: NetworkService {
  func fetchData(with request: URLRequest) async throws -> Data {
    try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...120_000_000))
    guard let url = Bundle.main.url(forResource: "example-response-1", withExtension: "json") else {
      throw ItineraryError.networkError
    }
    let data = try Data(contentsOf: url)
    return data
  }
}
