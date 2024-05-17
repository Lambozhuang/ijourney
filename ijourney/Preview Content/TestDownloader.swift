//
//  TestDownloader.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
  func httpData(from url: URL) async throws -> Data {
    try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...120_000_000))
    return testItineraryData
  }
}
