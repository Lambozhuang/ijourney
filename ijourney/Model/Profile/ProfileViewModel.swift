//
//  ProfileViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-20.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
  
  @Published var profile: Profile = Profile(name: "", birthday: .now)
  
  init() {
    
  }
}
