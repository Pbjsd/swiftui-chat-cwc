//
//  OnboardingContainverView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/20/22.
//

import SwiftUI

enum OnboardingStep: Int {
    
    case welcome = 0
    case phonenumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
}

struct OnboardingContainerView: View {
    
    @State var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea(edges: [.top, .bottom])
            
            switch currentStep {
                
            case .welcome:
                WelcomeView(currentStep: $currentStep)
                
            case .phonenumber:
                PhoneNumberView(currentStep: $currentStep)
                
            case .verification:
                VerificationView(currentStep: $currentStep)
                
            case .profile:
                CreateProfileView()
                
            case .contacts:
                SyncContactsView()
            }
        }
    
    }
}

struct OnboardingContainverView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView()
    }
}
