//
//  swiftui_chat_cwcApp.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/4/22.
//

import SwiftUI

@main
struct swiftui_chat_cwcApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var contactsViewModel = ContactsViewModel()
    @StateObject var chatViewModel = ChatViewModel()
    @StateObject var profileService = ProfileService()

    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(contactsViewModel)
                .environmentObject(chatViewModel)
                .environmentObject(settingsViewModel)
                .environmentObject(profileService)
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        }
    }
}
