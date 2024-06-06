//
//  CityViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

@MainActor
class CityViewModel: ObservableObject {
  
  let service: CityService
  
  init(service: CityService = CityService()) {
    self.service = service
  }
  
  
}
