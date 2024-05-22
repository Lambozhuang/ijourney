//
//  CityViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

@MainActor
class CityViewModel: ObservableObject {
  @Published var allCities: [City] = []
  @Published var selectedCity: City? = nil
  
}
