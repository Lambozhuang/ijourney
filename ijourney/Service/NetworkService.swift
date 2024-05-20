//
//  NetworkService.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

protocol NetworkService {
  func fetchData(with request: URLRequest) async throws -> Data
}

extension URLSession: NetworkService {
  func fetchData(with request: URLRequest) async throws -> Data {
    let (data, response) = try await self.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw ItineraryError.networkError
    }
    return data
  }
}
