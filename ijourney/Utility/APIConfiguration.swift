//
//  APIConfiguration.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import Foundation

class APIConfiguration {
  static let shared = APIConfiguration()
  
  private var config: [String: Any] = [:]
  
  private init() {
    loadConfig()
  }
  
  private func loadConfig() {
    if let url = Bundle.main.url(forResource: "API", withExtension: "plist") {
      do {
        let data = try Data(contentsOf: url)
        if let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
          config = plist
        }
      } catch {
        print("Error reading plist: \(error)")
      }
    }
  }
  
  var apiKey: String {
    return config["APIKey"] as? String ?? ""
  }
  
  var endpoint: String {
    return config["Endpoint"] as? String ?? ""
  }
  
  var systemPrompt: String {
    return config["SystemPrompt"] as? String ?? ""
  }
}
