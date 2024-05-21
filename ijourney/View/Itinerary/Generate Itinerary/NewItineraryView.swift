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
  @State private var itinerary = Itinerary()
  
  @State private var itineraryTask: Task<Void, Never>? = nil

  let userPrompt: String
  
  var body: some View {
    NavigationStack {
      VStack {
        if itineraryViewModel.isLoadingNewItinerary {
          ProgressView("Generating Itinerary...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
        } else {
          ItineraryDetail(isPreview: true, itinerary: itinerary)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbar {
        if itineraryViewModel.isLoadingNewItinerary {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
              itineraryTask?.cancel()
              dismissAll()
            }
          }
        } else {
          ToolbarItem(placement: .cancellationAction) {
            Button("Discard", role: .destructive) {
              dismissAll()
            }
          }
          ToolbarItem(placement: .confirmationAction) {
            Button("Add") {
              itineraryViewModel.addItinerary(itinerary: itinerary)
              dismissAll()
            }
          }
        }
      }
    }
    .onAppear {
      itineraryTask = Task {
        await generateItinerary()
      }
    }
  }
  
  private func generateItinerary() async {
    do {
      let itinerary = try await itineraryViewModel.service.fetchItinerary(userPrompt: userPrompt)
      self.itinerary = itinerary
      self.itineraryViewModel.isLoadingNewItinerary = false
    } catch {
      self.resultText = "Failed to generate itinerary: \(error.localizedDescription)"
      self.itineraryViewModel.isLoadingNewItinerary = false
    }
  }
  
  private func dismissAll() {
    itineraryViewModel.showGenerateItinerarySheet1 = false
    itineraryViewModel.showGenerateItinerarySheet1 = false
  }

}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestNetworkService()))
    var body: some View {
      NewItineraryView(userPrompt: "")
        .environmentObject(itineraryViewModel)
        .onAppear {
          itineraryViewModel.isLoadingNewItinerary = true
        }
    }
  }
  return Preview()
}
