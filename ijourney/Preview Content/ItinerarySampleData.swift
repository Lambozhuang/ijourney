//
//  ItinerarySampleData.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import Foundation
import SwiftData

@MainActor
class ItinerarySampleData {
  static let shared = ItinerarySampleData()
  
  let modelContainer: ModelContainer
  
  var context: ModelContext {
    modelContainer.mainContext
  }
  
  private init() {
    let schema = Schema([
      Itinerary.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
      modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
      
      insertSampleData()
      
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
  func insertSampleData() {
    for itinerary in Itinerary.sampleData {
      context.insert(itinerary)
    }
    
    do {
      try context.save()
    } catch {
      print("Sample data could not be saved.")
    }
  }
}
