//
//  NewItineraryView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import SwiftUI

struct NewItineraryView: View {
  
  @Environment(\.dismiss) var dismiss
  
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel
  @EnvironmentObject var cityViewModel: CityViewModel
  @EnvironmentObject var navigationState: NavigationState

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
        if navigationState.isLoadingNewItinerary {
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
        if !navigationState.isLoadingNewItinerary || errorMessage != nil {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", role: .destructive) {
              if errorMessage == nil {
                showDiscardAlert = true
              } else {
                dismiss()
              }
            }
          }
          ToolbarItem(placement: .confirmationAction) {
            Button("Add") {
              itineraryViewModel.addItinerary(itinerary: itinerary)
              navigationState.selectedTab = .itinerary
              navigationState.dismissAll()
            }
          }
        } else {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
              itineraryTask?.cancel()
              dismiss()
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
        dismiss()
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
        self.navigationState.isLoadingNewItinerary = false
      }
    } catch {
      self.errorMessage = "Failed to generate itinerary: \(error.localizedDescription)"
      print(errorMessage!)
      withAnimation {
        self.navigationState.isLoadingNewItinerary = false
      }
    }
  }
}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService()))
    @StateObject var navigationState = NavigationState()
    var body: some View {
      NewItineraryView(userPrompt: "", startDate: .now, endDate: .now)
        .environmentObject(itineraryViewModel)
        .environmentObject(CityViewModel())
        .environmentObject(navigationState)
        .onAppear {
          navigationState.isLoadingNewItinerary = true
        }
    }
  }
  return Preview()
}
