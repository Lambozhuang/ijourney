//
//  NewItineraryView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import SwiftUI

struct NewItineraryView: View {
  
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel

  @State private var resultText: String = ""
  
  let userPrompt: String
  
  var body: some View {
    VStack {
      if itineraryViewModel.isLoadingNewItinerary {
        ProgressView("Generating Itinerary...")
          .progressViewStyle(CircularProgressViewStyle())
          .padding()
      } else {
        ScrollView {
          Text(resultText)
            .padding()
        }
      }
    }
    .onAppear {
      Task {
        await generateItinerary()
      }
    }
  }
  
  private func generateItinerary() async {
    do {
      let itinerary = try await itineraryViewModel.service.fetchItinerary(userPrompt: userPrompt)
      let itineraryDescription = itineraryDescription(itinerary)
      DispatchQueue.main.async {
        self.resultText = itineraryDescription
        self.itineraryViewModel.isLoadingNewItinerary = false
      }
    } catch {
      DispatchQueue.main.async {
        self.resultText = "Failed to generate itinerary: \(error.localizedDescription)"
        self.itineraryViewModel.isLoadingNewItinerary = false
      }
    }
  }
  
  private func itineraryDescription(_ itinerary: Itinerary) -> String {
    var description = "Trip Plan:\n"
    description += "Target Country: \(itinerary.countryName ?? "None")\n"
    description += "Target City: \(itinerary.cityName ?? "None")\n"
    description += "Itinerary Length: \(itinerary.days.count) Days\n"
    description += "Personal Interests:\n"
    return description
  }
}

#Preview {
  NewItineraryView(userPrompt: "")
}
