//
//  EditInterestLevel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct EditInterestLevel: View {
  
  @Binding var showEditInterestLevel: Bool
  @State private var sliderValues: [InterestType: Double] = {
    var dict = [InterestType: Double]()
    InterestType.allCases.forEach { dict[$0] = 2.0 }
    return dict
  }()
  
  func interestLevel(for interestType: InterestType) -> InterestLevel {
    let index = Int(sliderValues[interestType] ?? 0)
    return InterestLevel.allCases[index]
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
              Text(interestLevel(for: interestType).rawValue)
                .font(.subheadline)
            }
            Slider(value: Binding(
              get: { self.sliderValues[interestType] ?? 0.0 },
              set: { newValue in self.sliderValues[interestType] = newValue }
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
            showEditInterestLevel = false
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            
          }
        }
      }
    }
  }
}

#Preview {
  EditInterestLevel(showEditInterestLevel: .constant(true))
}
