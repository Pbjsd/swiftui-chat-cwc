//
//  VerificationView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/21/22.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool 
    
    @State var verificationcode = ""
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("imput"))
                
                HStack {
                    TextField("", text: $verificationcode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationcode)) { _ in
                            TextHelper.limitText(&verificationcode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationcode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                    
                    
                    
                }
                .padding()
                
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationcode) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            
                            if exists {
                                // End the onboarding
                                isOnboarding = false
                            }
                            else {
                                // Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // TODO: Show error message
                    }
                }
                
                
                
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
            }
        .padding(.horizontal)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep:
                .constant(.verification), isOnboarding: .constant(true))
    }
}
