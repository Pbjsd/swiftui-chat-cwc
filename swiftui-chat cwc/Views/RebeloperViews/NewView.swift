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
        }

        HStack {
          Spacer()
          Button {
          } label: {
            Image(systemName: "xmark.circle.fill")
              .imageScale(.large)
              .foregroundColor(.red)
              .scaleEffect(2)
              .padding()
          }
          Spacer()

          Button {
          } label: {
            Image(systemName: "heart.fill")
              .imageScale(.large)
              .foregroundColor(.green)
              .scaleEffect(2)
              .padding()

          }

          Spacer()
        }


        HStack {
          Spacer()
          VStack {
            Text("Name:")
            Text("Gender:")
            Text("Age:")
            Text("Occupation:")
            Text("Hobbies:")
            Text("Bio:")
            Text("I am looking for...")
            //                Text("Eighth")
            //                Text("Ninth")
            //                Text("Tenth")

          }
          .padding()
          Spacer()
        }
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(30)
        .frame(width: UIScreen.main.bounds.size.width * 0.9)
//
//        RoundedRectangle(cornerRadius: 30)
//          .padding(.horizontal)
//          .foregroundColor(.white)
      }
      .frame(width: UIScreen.main.bounds.size.width)

//    https://firebasestorage.googleapis.com:443/v0/b/swiftui-chat-app-9ed71.appspot.com/o/images%2FF17EE09F-CC6A-41DF-94E6-F63F9BFBCBD7.jpg?alt=media&token=fbf06e59-aad2-49d4-b002-5f5ab2f6bdd0


//
//
//      VStack {
//        Spacer()
//
//        ZStack {
//
//            RoundedRectangle(cornerRadius: 30)
//              .padding(.horizontal)
//              .foregroundColor(.white)
//          Text("Sandy")
//            .font(.title)
//            .multilineTextAlignment(.leading)
//            .padding([.top, .trailing], 275.0)
//
//
//
//        }
//
//        Spacer()
//        HStack {
//          Spacer()
//          Button {
//          } label: {
//            Image(systemName: "xmark.circle.fill")
//              .imageScale(.large)
//              .foregroundColor(.red)
//              .scaleEffect(2)
//              .padding()
//          }
//          Spacer()
//
//          Button {
//          } label: {
//            Image(systemName: "heart.fill")
//              .imageScale(.large)
//              .foregroundColor(.green)
//              .scaleEffect(2)
//              .padding()
//
//          }
//
//          Spacer()
//
//        }
//
//        ZStack {
//          RoundedRectangle(cornerRadius: 30)
//            .padding(.horizontal)
//            .foregroundColor(.white)
//
//          ScrollView {
//              VStack {
//                  Text("Name:")
//                  Text("Gender:")
//                  Text("Age:")
//                  Text("Occupation:")
//                  Text("Hobbies:")
//                  Text("Bio:")
//                  Text("I am looking for...")
//  //                Text("Eighth")
//  //                Text("Ninth")
//  //                Text("Tenth")
//
//              }.frame(maxWidth: .infinity) // <1>
//          }.font(.largeTitle)
//
//        }
//
//
//      }
//
//      .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
//      .accentColor(Color.black)
//      .background(Color("backgroundcolor").gradient)
    }
}
//
//struct NewView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewView()
//    }
//}
