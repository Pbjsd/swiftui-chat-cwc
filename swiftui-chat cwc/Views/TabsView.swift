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
        //Tried to add ChatsListView() above but kept getting errors 
          .tabItem {
            Image(systemName: "message")
          }
        UsersListView()
          .tabItem {
            Image(systemName: "person")
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
