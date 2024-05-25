//
//  NewItineraryView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import SwiftUI

struct NewItineraryView: View {
  
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel
  @EnvironmentObject var cityViewModel: CityViewModel

  @State private var itinerary = Itinerary()
  @State private var itineraryTask: Task<Void, Never>? = nil
  @State private var errorMessage: String? = nil
  @State private var showDiscardAlert = false

  let userPrompt: String
  let startDate: Date
  let endDate: Date
  
  var body: some View {
    NavigationStack {
      VStack {
        if itineraryViewModel.isLoadingNewItinerary {
          ProgressView("Generating Itinerary...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
        } else if let errorMessage {
          Text(errorMessage)
            .padding()
        } else {
          ItineraryDetail(isPreview: true, itinerary: itinerary)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbar {
        if !itineraryViewModel.isLoadingNewItinerary || errorMessage != nil {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", role: .destructive) {
              if errorMessage == nil {
                showDiscardAlert = true
              } else {
                dismissAll()
              }
            }
          }
          ToolbarItem(placement: .confirmationAction) {
            Button("Add") {
              itineraryViewModel.addItinerary(itinerary: itinerary)
              dismissAll()
            }
          }
        } else {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
              itineraryTask?.cancel()
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
    .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
      Button("Discard Itinerary", role: .destructive) {
        cityViewModel.selectedCity = nil
        dismissAll()
      }
    }
  }
  
  private func generateItinerary() async {
    do {
      var itinerary = try await itineraryViewModel.service.fetchItinerary(userPrompt: userPrompt)
      itinerary.startDate = startDate
      itinerary.endDate = endDate
      self.itinerary = itinerary
      withAnimation {
        self.itineraryViewModel.isLoadingNewItinerary = false
      }
    } catch {
      self.errorMessage = "Failed to generate itinerary: \(error.localizedDescription)"
      print(errorMessage!)
      withAnimation {
        self.itineraryViewModel.isLoadingNewItinerary = false
      }
    }
  }
  
  private func dismissAll() {
    cityViewModel.selectedCity = nil
    itineraryViewModel.showGenerateItinerarySheet1 = false
    itineraryViewModel.showGenerateItinerarySheet1 = false
  }

}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService()))
    var body: some View {
      NewItineraryView(userPrompt: "", startDate: .now, endDate: .now)
        .environmentObject(itineraryViewModel)
        .environmentObject(CityViewModel())
        .onAppear {
          itineraryViewModel.isLoadingNewItinerary = true
        }
    }
  }
  return Preview()
}
