//
//  APIConfiguration.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import Foundation

class APIConfiguration {
  static let shared = APIConfiguration()
  
  private var chatGPTConfiguration: [String: Any] = [:]
  private var geoDBConfiguration: [String: Any] = [:]
  
  private init() {
    loadChatGPTConfiguration()
    loadGeoDBConfiguration()
  }
  
  private func loadChatGPTConfiguration() {
    if let url = Bundle.main.url(forResource: "AzureOpenAIAPI", withExtension: "plist") {
      do {
        let data = try Data(contentsOf: url)
        if let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
          chatGPTConfiguration = plist
        }
      } catch {
        print("Error reading plist: \(error)")
      }
    }
  }
  
  private func loadGeoDBConfiguration() {
    if let url = Bundle.main.url(forResource: "GeoDBAPI", withExtension: "plist") {
      do {
        let data = try Data(contentsOf: url)
        if let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
          geoDBConfiguration = plist
        }
      } catch {
        print("Error reading plist: \(error)")
      }
    }
  }
  
  var chatGPTAPIKey: String? {
    return chatGPTConfiguration["APIKey"] as? String
  }
  
  var chatGPTEndpoint: String? {
    return chatGPTConfiguration["Endpoint"] as? String
  }
  
  var systemPrompt: String? {
    return chatGPTConfiguration["SystemPrompt"] as? String
  }
  
  var geoDBAPIKey: String? {
    return geoDBConfiguration["APIKey"] as? String
  }
  
  var geoDBEndpoint: String? {
    return geoDBConfiguration["Endpoint"] as? String
  }
}
