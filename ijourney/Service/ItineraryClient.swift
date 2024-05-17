//
//  ItineraryClient.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

actor ItineraryClient {
  
  var itinerary: Itinerary {
    get async throws {
      let data = try await downloader.httpData(from: feedURL)
      let itineraryList = try decoder.decode(Itinerary.self, from: data)
      return itineraryList
    }
  }
  
  private lazy var decoder: JSONDecoder = {
    let aDecoder = JSONDecoder()
    return aDecoder
  }()
  
  private let feedURL = URL(string: "233")!

  
  private let downloader: any HTTPDataDownloader
  
  
  init(downloader: any HTTPDataDownloader = URLSession.shared) {
    self.downloader = downloader
  }
  
}
