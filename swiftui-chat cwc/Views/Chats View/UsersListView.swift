//
//  UsersListView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/9/23.
//

import SwiftUI

struct UsersListView: View {

  @Binding var isChatShowing: Bool
  @Binding var isSettingsShowing: Bool

  @EnvironmentObject private var profileService: ProfileService

  @State private var offsets = Array(repeating: CGSize.zero, count: 10000)
  @State private var redOpacity = 0.0

    var body: some View {
      ZStack {
        Text("No more users")
          .font(.caption)
          .foregroundColor(.gray)
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
          .if(!profileService.otherUsers.isEmpty, transform: { view in
            view
              .offset(x: offsets[index].width, y: offsets[index].height * 0.4)
              .rotationEffect(.degrees(Double(offsets[index].width / 40)))
          })
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  offsets[index] = gesture.translation
                  withAnimation {
//                    changeColor(width: offsets[index].width)
                  }

                } .onEnded { _ in
                  withAnimation {
                    swipeCard(width: offsets[index].width, index: index)
//                    changeColor(width: offset.width)
                  }
                }
            )
              .overlay {
            Color.red.opacity(redOpacity)
          }
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

//  func changeColor(width: CGFloat) {
//    switch width {
//    case -500...(-150):
//      redOpacity = width - 50
//    case 150...500:
//      redOpacity = width - 50
//    default:
//      redOpacity = 0
//    }
//  }

  func swipeCard(width: CGFloat, index: Int) {
    switch width {
    case -500...(-150):
      //          print("\(person) removed")
      offsets[index] = CGSize(width: -500, height: 0)
    case 150...500:
      //          print("\(person) added")
      offsets[index] = CGSize(width: 500, height: 0)
    default:
      offsets[index] = .zero
    }
  }
}

