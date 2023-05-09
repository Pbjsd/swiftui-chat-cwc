//
//  NewView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 4/26/23.
//

import SwiftUI

struct NewView: View {

  @Binding var isChatShowing: Bool
  @Binding var isSettingsShowing: Bool

  @EnvironmentObject private var profileService: ProfileService

  var body: some View {
    ScrollView {

            AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/swiftui-chat-app-9ed71.appspot.com/o/images%2FF17EE09F-CC6A-41DF-94E6-F63F9BFBCBD7.jpg?alt=media&token=fbf06e59-aad2-49d4-b002-5f5ab2f6bdd0")) { image in
              image
                .resizable()
                .scaledToFill()

              } placeholder: {
                ProgressView()
              }
              .background(.white)
              .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.7)
              .clipShape(RoundedRectangle(cornerRadius: 30))
              .cornerRadius(30)
              .overlay(alignment: .bottomLeading) {
                Text("My name")
                  .foregroundColor(.white)
                  .padding()


        if let currentUser = profileService.currentUser {
          Text("First Name: \(currentUser.firstname ?? "")")
          Text("Last Name: \(currentUser.lastname ?? "")")
          Text("Gender: \(currentUser.gender ?? "")")
          Text("Age: \(currentUser.age ?? "")")
          Text("Occupation: \(currentUser.occupation ?? "")")
          Text("Hobbies: \(currentUser.hobbies ?? "")")
          Text("Bio: \(currentUser.bio ?? "")")
          Text("I am looking for: \(currentUser.iamlookingfor ?? "")")
        }

        HStack {
          Spacer()
          VStack {
            //  Text("Name:")
            @State var firstName = ""
            @State var lastName = ""
            @State var gender = ""
            @State var age = ""
            @State var occupation = ""
            @State var hobbies = ""
            @State var bio = ""
            @State var iAmLookingFor = ""
            @State var photo = ""

          }
          .padding()
          Spacer()
        }


        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(30)
        .frame(width: UIScreen.main.bounds.size.width * 0.9)

      }
      .frame(width: UIScreen.main.bounds.size.width)
      .onAppear {
        profileService.fetchCurrentUser()
      }

      //    https://firebasestorage.googleapis.com:443/v0/b/swiftui-chat-app-9ed71.appspot.com/o/images%2FF17EE09F-CC6A-41DF-94E6-F63F9BFBCBD7.jpg?alt=media&token=fbf06e59-aad2-49d4-b002-5f5ab2f6bdd0

    }
  }
  //
  //struct NewView_Previews: PreviewProvider {
  //    static var previews: some View {
  //        NewView()
  //    }
  //}

}
