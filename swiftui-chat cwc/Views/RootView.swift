//
//  RootView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/4/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    @State var isOnboarding =
        !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        
        VStack {
            
        Text("Hello, world!")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
       
            CustomTabBar(selectedTab: $selectedTab)
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // On dismiss
        } content: {
            // The onboarding sequence
            OnboardingContainerView()
        }

        
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
