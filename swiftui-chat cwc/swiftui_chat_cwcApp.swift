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
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
                .environmentObject(ChatViewModel())
        }
    }
}
