//
//  NewView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 4/26/23.
//

import SwiftUI

struct NewView: View {

  @EnvironmentObject private var profileService: ProfileService

  @State var user: User?

  var body: some View {

    ScrollView {

      VStack {
        AsyncImage(url: URL(string: user?.photo ?? "")) { image in
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

          Text(user?.firstname ?? "")
            .frame(maxHeight: .infinity, alignment: .bottomLeading)
            .foregroundColor(.white)
            .padding()


            .cornerRadius(30)
            .frame(width: UIScreen.main.bounds.size.width * 0.9)

            .frame(width: UIScreen.main.bounds.size.width)
            .onAppear {
              if user == nil {
                user = profileService.currentUser
              }
            }


        }
      }
      ZStack {
          RoundedRectangle(cornerRadius: 30)
            .fill(Color.white)
            .frame(width: UIScreen.main.bounds.size.width*0.9)
          VStack {
            if let currentUser = user {
              Text("First Name: \(currentUser.firstname ?? "")")
              Text("Last Name: \(currentUser.lastname ?? "")")
              Text("Gender: \(currentUser.gender ?? "")")
              Text("Age: \(currentUser.age ?? "")")
              Text("Occupation: \(currentUser.occupation ?? "")")
              Text("Hobbies: \(currentUser.hobbies ?? "")")
              Text("Bio: \(currentUser.bio ?? "")")
              Text("I am looking for: \(currentUser.iamlookingfor ?? "")")
            }

          }


        }
      }
    }
  }

