//
//  ProfileView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ProfileView: View {
  
  var profile: Profile
  
  @State private var showEditProfile = false
  @State private var showEditInterestLevel = false
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          HStack {
            Image(systemName: "person.circle")
              .font(.system(size: 60))
            VStack(alignment: .leading) {
              Text(profile.name)
                .font(.largeTitle)
              Text(profile.birthday.formatted(date: .numeric, time: .omitted))
                .font(.title3)
            }
            .padding(.leading)
            Spacer()
          }
          VStack(alignment: .leading) {
            Text("Additional Information")
              .bold()
            if let secondaryLangauge = profile.secondaryLangauge {
              Text("Languages: \(profile.primaryLanguage!.displayName), \(secondaryLangauge)")
            } else {
              Text("Language: \(profile.primaryLanguage!.displayName)")
            }
          }
          
        }
        
        Section {
          Button {
            showEditProfile = true
          } label: {
            Text("Edit Profile")
          }
          Button {
            showEditInterestLevel = true
          } label: {
            Text("Edit Interest Level")
          }
        }
        
        Section {
          NavigationLink {
            Text("About")
          } label: {
            Text("About")
          }
        }
        
      }
      .navigationTitle("My Profile")
      .sheet(isPresented: $showEditProfile) {
        EditProfile(showEditProfile: $showEditProfile)
          .interactiveDismissDisabled()
      }
      .sheet(isPresented: $showEditInterestLevel) {
        EditInterestLevel(showEditInterestLevel: $showEditInterestLevel)
          .interactiveDismissDisabled()
      }
    }
  }
}

#Preview {
  ProfileView(profile: Profile.sampleData)
}
