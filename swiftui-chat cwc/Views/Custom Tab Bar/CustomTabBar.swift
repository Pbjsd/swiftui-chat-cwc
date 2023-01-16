//
//  CustomTabBar.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/10/22.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack (alignment: .center) {
            
            Button {
                // Switch to chats
                selectedTab = .chats
                
            } label: {
                
                TabBarButton(buttonText: "Chats",
                             imageName: "bubble.left",
                             isActive: selectedTab == .chats)
 // this code no longer needed- refer to Lesson 4: Creating a Custom Tab bar 
//                GeometryReader { geo in
//
//                    if selectedTab == .chats {
//                        Rectangle()
//                            .foregroundColor(.blue)
//                            .frame(width: geo.size.width/2, height: 4)
//                            .padding(.leading, geo.size.width/4)
//                    }
//
//
//                    VStack (alignment: .center, spacing: 4) {
//
//                        Image(systemName: "bubble.left")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24, height: 24)
//
//                        Text("Chats")
//                            .font(Font.tabBar)
//                    }
//                    .frame(width: geo.size.width, height: geo.size.height)
//
//                }
                
            }
            .tint(Color("icons-secondary"))
            
            Button {
                // New chat
                // TODO: This is not going to be the permanent home for logout
                AuthViewModel.logout()
            } label: {
                
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New Chat")
                        .font(Font.tabBar)
                }
                
            }
            .tint(Color("icons-primary"))
            
            
            
            Button {
                // Switch to contacts
                selectedTab = .contacts
            } label: {
                
                TabBarButton(buttonText: "Contacts",
                             imageName: "person",
                             isActive: selectedTab == .contacts)
            }
            .tint(Color("icons-secondary"))
            
            
        }
        .frame(height: 82)
        
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.contacts))
    }
}
