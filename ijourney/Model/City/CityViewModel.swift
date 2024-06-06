//
//  CityViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

@MainActor
class CityViewModel: ObservableObject {
  
  @Published var featuredCities: [City] = []
  
  let service: CityService
  
  init(service: CityService = CityService()) {
    self.service = service
    loadFeaturedCities()
    loadLocalImages()
  }
  
  private func loadFeaturedCities() {
    featuredCities = City.sampleData
  }
  
  private func loadLocalImages() {
    featuredCities.indices.forEach { index in
      featuredCities[index].loadLocalImage()
    }
  }
}
