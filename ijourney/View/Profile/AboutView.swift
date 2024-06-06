//
//  AboutView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-18.
//

import SwiftUI

struct AboutView: View {

  var body: some View {
    VStack {
      Text("iJourney")
      Text("Version 0.0.1")
      Spacer()
    }
    .navigationTitle("About")
    .navigationBarTitleDisplayMode(.inline)
    .padding()
  }
}

#Preview {
  AboutView()
}
