//
//  EditInterestLevel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct EditInterestLevel: View {
  
  @Environment(\.dismiss) var dismiss
  
  @State private var showDiscardAlert = false
  @Binding var currentInterests: Interests
  @State private var newInterests = Interests()
  @State private var sliderValues: [InterestType: Double] = [:]
  
  var isChanged: Bool {
    currentInterests != newInterests
  }
  
  var body: some View {
    NavigationStack {
      List {
        Text("Here you can adjust your interest level for each category.")
          .font(.callout)
        ForEach(InterestType.allCases, id: \.self) { interestType in
          VStack {
            HStack {
              Text("\(interestType.emoji) \(interestType.rawValue)")
                .font(.headline)
              Spacer()
              Text(InterestLevel(value: sliderValues[interestType] ?? 0).rawValue)
                .font(.subheadline)
            }
            Slider(value: Binding(
              get: { self.sliderValues[interestType] ?? 0.0 },
              set: { newValue in
                self.sliderValues[interestType] = newValue
                self.newInterests[interestType] = InterestLevel(value: newValue)
              }
            ), in: 0...4, step: 1) {
              Text(interestType.rawValue)
            }
          }
        }
      }
      .navigationTitle("Edit Interest Levels")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            if isChanged {
              showDiscardAlert = true
            } else {
              dismiss()
            }
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            currentInterests = newInterests
            dismiss()
          }
        }
      }
    }
    .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
      Button("Discard Changes", role: .destructive) {
        dismiss()
      }
    }
    .onAppear {
      newInterests = currentInterests
      InterestType.allCases.forEach {
        sliderValues[$0] = currentInterests[$0]?.value ?? 2
      }
    }
    .interactiveDismissDisabled(isChanged)
  }
}

#Preview {
  EditInterestLevel(currentInterests: .constant(Interests()))
}
