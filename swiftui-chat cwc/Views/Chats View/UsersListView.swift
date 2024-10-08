//
//  UsersListView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/9/23.
//

import SwiftUI
import FirebaseFirestore

struct UsersListView: View {

  @EnvironmentObject private var profileService: ProfileService

  @State private var offsets = Array(repeating: CGSize.zero, count: 10000)
  @State private var redOpacities = Array(repeating: 0.0, count: 10000)

  var body: some View {
    ZStack {
      VStack {

        Spacer()

        Image("no-chats-yet")

        Text("No more users")
          .font(Font.titleText)
          .padding(.top, 32)

        Text("Try expanding your filters!")
          .font(Font.bodyParagraph)
          .padding(.top, 8)


        Spacer()
      }
      ForEach(profileService.otherUsers.indices, id: \.self) { index in
        let user = profileService.otherUsers[index]

        VStack {
          AsyncImage(url: URL(string: user.photo ?? "")) { image in
            image
              .resizable()
              .scaledToFill()

          } placeholder: {
            ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .tint(.orange)
          }
          .background(.white)
          .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.7)
          .clipShape(RoundedRectangle(cornerRadius: 30))
          .cornerRadius(30)
          .overlay(alignment: .bottomLeading) {
            Text(user.firstname ?? "")
              .foregroundColor(.white)
              .padding()
          }
        }
        .foregroundColor(.red.opacity(redOpacities[index]))
        .if(!profileService.otherUsers.isEmpty, transform: { view in
          view
            .offset(x: offsets[index].width, y: offsets[index].height * 0.4)
            .rotationEffect(.degrees(Double(offsets[index].width / 40)))
        })
          .gesture(
            DragGesture()
              .onChanged { gesture in
                //                  offsets[index] = gesture.translation
                offsets[index].width = gesture.translation.width
                withAnimation {
                  changeColor(width: offsets[index].width, index: index)
                }

              } .onEnded { _ in
                withAnimation {
                  swipeCard(width: offsets[index].width, index: index)
                  //                    changeColor(width: offset.width)
                }
              }
          )
      }
    }
    .onReceive(profileService.$currentUser, perform: { _ in
      Task {
        do {
          try await profileService.fetchOtherUsers()
        } catch {
          print(error.localizedDescription)
        }
      }
    })
  }

  func changeColor(width: CGFloat, index: Int) {
    switch width {
    case -500...(-150):
      redOpacities[index] = width - 50
    case 150...500:
      print(width)
      var opacity = width / 300
      print("opacity: \(opacity)")
      print("index: \(index)")
      redOpacities[profileService.otherUsers.count] = opacity
    default:
      redOpacities[index] = 0
    }
  }

  func swipeCard(width: CGFloat, index: Int) {
    switch width {
    case -500...(-150):
      //          print("\(person) removed")
      offsets[index] = CGSize(width: -500, height: 0)
    case 150...500:
      //          print("\(person) added")
      offsets[index] = CGSize(width: 500, height: 0)
      if let uid = profileService.otherUsers[index].uid {
        matched(uid: uid)
      }

    default:
      offsets[index] = .zero
    }
    profileService.otherUsers.remove(at: index)
  }

  func matched(uid: String) {
    guard let myUid = profileService.currentUser?.uid else { return }
    let match = Match(uid: "", myUid: myUid, otherUid: uid, createdAt: Timestamp())
    Task {
      do {
        try await FirestoreContext.create(match, collectionPath: "matches")
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

