//
//  SettingsView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 3/15/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSettingsShowing: Bool
    @Binding var isOnboarding: Bool
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    
    
    var body: some View {
        
        
        
        ZStack {
            
          // Background
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                // Heading
                HStack {
                    Text("Settings")
                        .font(Font.pageTitle)
                    
                    Spacer()
                    
                    Button {
                        // Close settings view
                        isSettingsShowing = false
                        
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(Color("icons-secondary"))
                    }
                    
                    
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // The Form
                Form {
                    
                    Toggle("Dark Mode", isOn: $settingsViewModel.isDarkMode)
                    
                    Button {
                        // Log out
                        AuthViewModel.logout()
                        
                        // Show login screen again
                        isSettingsShowing = false
                        isOnboarding = true
                        
                    } label: {
                        Text("Log Out")
                    }
                    
                    Button {
                        // Call deactivate account
                        settingsViewModel.deactivateAccount {
                            
                            // Deactivated, logout and show onboarding
                            AuthViewModel.logout()
                            
                            isOnboarding = true 
                        }
                        
                    } label: {
                        Text("Delete Account")
                    }
                }
                .background(Color("background"))
            }
            
        }
        .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        
        
    }
}

