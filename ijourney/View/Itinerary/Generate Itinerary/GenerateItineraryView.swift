//
//  GenerateItineraryView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-18.
//

import SwiftUI

struct GenerateItineraryView: View {
  
  @Environment(\.dismiss) var dismiss
  
  @State private var showDiscardAlert = false

  var city: City
  
  var body: some View {
    NavigationStack {
      Form {
        Text(city.name)
      }
      .navigationTitle("Generate Itinerary")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel", role: .cancel) {
            showDiscardAlert = true
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            
          }
        }
      }
    }
    .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
      Button("Discard Changes", role: .destructive) {
        dismiss()
      }
    }
  }
}

#Preview {
  GenerateItineraryView(city: City(name: "Rome", countryName: "Italy"))
}
