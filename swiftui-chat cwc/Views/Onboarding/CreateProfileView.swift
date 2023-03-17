//
//  CreateProfileView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/21/22.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    @State var isErrorLabelVisible = false
    @State var errorMessage = ""
    
    var body: some View {
        
        VStack {
            
            Text("Setup your Profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            // Profile image button
            Button {
                
                // Show action sheet
                isSourceMenuShowing = true
                
            } label: {
                
                ZStack {
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                    else {
                        Circle()
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                }
                .frame(width: 134, height: 134)
                
            }

            Spacer()
            
            // First name
            TextField("Given Name", text: $firstName)
                .textFieldStyle(CreateProfileTextfieldStyle())
                .placeholder(when: firstName.isEmpty) {
                        Text("Given Name")
                            .foregroundColor(Color("text-textfield"))
                            .font(Font.bodyParagraph)
                    }
                  
            // Last name
            TextField("Last Name", text: $lastName)
                .textFieldStyle(CreateProfileTextfieldStyle())
                .placeholder(when: lastName.isEmpty) {
                        Text("Last Name")
                            .foregroundColor(Color("text-textfield"))
                            .font(Font.bodyParagraph)
                    }
            
            // Error label
            Text(errorMessage)
                .foregroundColor(.red)
                .font(Font.smallText)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                
                // Hide error message
                isErrorLabelVisible = false
                
                // Check that firstname/lastname fields are filled before allowing to save
                guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    
                    errorMessage = "Please enter in a valid first and last name."
                    isErrorLabelVisible = true
                    return 
                }
                
                // Prevent double taps
                isSaveButtonDisabled = true
                
                // Save the data
                DatabaseService().setUserProfile(firstName: firstName,
                                                 lastName: lastName,
                                                 image: selectedImage) { isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                    }
                    else {
                        // Show error message to the user
                        errorMessage = "Error occurred. Please try again."
                        isErrorLabelVisible = true
                    }
                    
                    isSaveButtonDisabled = false
                }
                
            } label: {
                Text(isSaveButtonDisabled ? "Uploading" : "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
            .padding(.bottom, 87)

            
        }
        .padding(.horizontal)
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                // Set the source to photo library
                self.source = .photoLibrary
                
                // Show the image picker
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
                Button {
                    // Set the source to camera
                    self.source = .camera
                    
                    // Show the image picker
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }

            
        })
        .sheet(isPresented: $isPickerShowing) {
            
            // Show the image picker
            ImagePicker(selectedImage: $selectedImage,
                        isPickerShowing: $isPickerShowing, source: self.source)
        }
        
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}

