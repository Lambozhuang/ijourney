//
//  WelcomeView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-10.
//

import SwiftUI

struct WelcomeView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Image("icon")
          .resizable()
          .scaledToFit()
          .clipShape(.rect(cornerRadius: 35))
          .frame(width: 150, height: 150)
          .shadow(radius: 3)
          .padding()
        HStack {
          ZStack {
            Rectangle()
              .fill(.yellow)
              .clipShape(.rect(cornerRadius: 15))
              .frame(width: 60, height: 60)
            Image(systemName: "magnifyingglass")
              .font(.largeTitle)
          }
          .padding(10)
          Text("Find the city to travel")
            .bold()
          Spacer()
        }
        HStack {
          ZStack {
            Rectangle()
              .fill(.orange)
              .clipShape(.rect(cornerRadius: 15))
              .frame(width: 60, height: 60)
            Image(systemName: "square.and.pencil")
              .font(.largeTitle)
          }
          .padding(10)
          Text("Adjust your interest")
            .bold()
          Spacer()
        }
        HStack {
          ZStack {
            Rectangle()
              .fill(.purple)
              .clipShape(.rect(cornerRadius: 15))
              .frame(width: 60, height: 60)
            Image(systemName: "sparkles")
              .font(.largeTitle)
          }
          .padding(10)
          Text("Generate itinerary")
            .bold()
          Spacer()
        }
        Spacer()
        NavigationLink {
          WelcomeFormView()
        } label: {
          Text("Continue")
            .frame(width: UIScreen.main.bounds.width - 80, height: 35)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        
      }
      .padding()
      .navigationTitle("Welcome to iJourney!")
      .navigationBarTitleDisplayMode(.large)
    }
    .interactiveDismissDisabled()
  }
}

#Preview {
  WelcomeView()
    .environmentObject(NavigationState())
}
