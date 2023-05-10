//
//  TabsView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/10/23.
//

import SwiftUI

struct TabsView: View {

  @EnvironmentObject private var profileService: ProfileService

    var body: some View {
      TabView {
        ContactsListView()
          .tabItem {
            Image(systemName: "person")
          }
        UsersListView()
          .tabItem {
            Image(systemName: "house")
          }

        NewView(user: nil)
          .tabItem {
            Image(systemName: "house")
          }
      }
      .onAppear {
        profileService.fetchCurrentUser()
      }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
