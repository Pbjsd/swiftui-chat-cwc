//
//  RootView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/4/22.
//

import SwiftUI

struct RootView: View {
    
    // For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
  @EnvironmentObject private var profileService: ProfileService
    
    @State var selectedTab: Tabs = .contacts
    
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    @State var isChatShowing = false
    
    @State var isSettingsShowing = false
    
    var body: some View {
        
      VStack {

          switch selectedTab {

          case .chats:
            UsersListView(isChatShowing: $isChatShowing,
                          isSettingsShowing: $isSettingsShowing)
//            NewView(isChatShowing: $isChatShowing,
//                    isSettingsShowing: $isSettingsShowing)
//                    ChatsListView(isChatShowing: $isChatShowing,
//                                  isSettingsShowing: $isSettingsShowing)
          case .contacts:
              ContactsListView(isChatShowing: $isChatShowing,
                               isSettingsShowing: $isSettingsShowing)
          }

          Spacer()

          CustomTabBar(selectedTab: $selectedTab, isChatShowing: $isChatShowing)
      }
      .background(Color("background")
        .ignoresSafeArea())
        .onAppear(perform: {
            if !isOnboarding {
                // User has already onboarded, load contacts
                contactsViewModel.getLocalContacts()
            }
        })
        .fullScreenCover(isPresented: $isOnboarding) {
            // On dismiss
        } content: {
            // The onboarding sequence
            OnboardingContainerView(isOnboarding: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            
            // The conversation view
          ConversationView(isChatShowing: $isChatShowing, isSettingsShowing: $isSettingsShowing)
        }
        .fullScreenCover(isPresented: $isSettingsShowing, onDismiss: nil, content: {
            
            // The Settings View
            SettingsView(isSettingsShowing: $isSettingsShowing,
                         isOnboarding: $isOnboarding)
        })
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
                chatViewModel.chatListViewCleanup()
            }
        }
        .onAppear {
          profileService.fetchCurrentUser()
        }
        
    }

    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
