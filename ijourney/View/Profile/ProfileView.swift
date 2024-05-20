//
//  ProfileView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ProfileView: View {
  
  @EnvironmentObject var profileViewModel: ProfileViewModel
  
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
              Text(profileViewModel.profile.name)
                .font(.largeTitle)
              Text(profileViewModel.profile.birthday.formatted(date: .numeric, time: .omitted))
                .font(.title3)
            }
            .padding(.leading)
            Spacer()
          }
          VStack(alignment: .leading) {
            Text("Additional Information")
              .bold()
            if profileViewModel.profile.secondaryLangauge != .none {
              Text("Languages: \(profileViewModel.profile.primaryLanguage.displayName), \(profileViewModel.profile.secondaryLangauge.displayName)")
            } else {
              Text("Language: \(profileViewModel.profile.primaryLanguage.displayName)")
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
        EditProfile(showEditProfile: $showEditProfile, currentProfile: $profileViewModel.profile)
      }
      .sheet(isPresented: $showEditInterestLevel) {
        EditInterestLevel(currentInterests: $profileViewModel.profile.interests)
      }
    }
  }
}

#Preview {
  ProfileView()
    .environmentObject(ProfileViewModel())
}
