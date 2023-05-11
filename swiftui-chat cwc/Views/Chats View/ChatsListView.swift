//
//  ChatsListView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 1/21/23.
//

import SwiftUI

struct ChatsListView: View {

  @EnvironmentObject var chatViewModel: ChatViewModel
  @EnvironmentObject var contactsViewModel: ContactsViewModel

  @Binding var isChatShowing: Bool
  @Binding var isSettingsShowing: Bool

  @State private var offsets = Array(repeating: CGSize.zero, count: 10000)

  var body: some View {

    VStack {

      

      // Heading
      HStack {
        Text("Chats")
          .font(Font.pageTitle)

        Spacer()

        Button {
          // Shows settings
          isSettingsShowing = true
        } label: {
          Image(systemName: "gearshape.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .tint(Color("icons-secondary"))
        }


      }
      .padding(.top, 20)
      .padding(.horizontal)

      // Chat list
      if chatViewModel.chats.count > 0 {
        List {
          ForEach(0..<chatViewModel.chats.count, id: \.self) { index in
            let chat = chatViewModel.chats[index]
            let otherParticipants = contactsViewModel.getParticipants(ids: chat.participantids)

            // Detect if it's a chat with a deleted user
            if let otherParticipant = otherParticipants.first,
               chat.numparticipants == 2,
               !otherParticipant.isactive {

              // This is a conversation with a deleted user, don't show anything

            }
            else {

              //                        Button {
              //
//                                          // Set selcted chat for the chatviewmodel
//                                          chatViewModel.selectedChat = chat
//
//                                          // display conversation view
//                                          isChatShowing = true
              //
              //                        } label: {
              ////
              //                            ChatsListRow(chat: chat,
              //                                         otherParticipants: otherParticipants)
              //                        }
              //                        .buttonStyle(.plain)
              //                        .listRowBackground(Color.clear)
              //                        .listRowSeparator(.hidden)

              ChatsListRow(chat: chat,
                           otherParticipants: otherParticipants)
              .onTapGesture {
                // Set selcted chat for the chatviewmodel
                chatViewModel.selectedChat = chat

                // display conversation view
                isChatShowing = true
              }
              .listRowBackground(Color.clear)
              .listRowSeparator(.hidden)
              .if(!chatViewModel.chats.isEmpty, transform: { view in
                view
                  .offset(x: offsets[index].width, y: offsets[index].height * 0.4)
                  .rotationEffect(.degrees(Double(offsets[index].width / 40)))
              })
              .gesture(
                DragGesture()
                  .onChanged { gesture in
                    offsets[index] = gesture.translation
                    withAnimation {
                      //                                    changeColor(width: offset.width)
                    }

                  } .onEnded { _ in
                    withAnimation {
                      swipeCard(width: offsets[index].width, index: index)
                      //                                    changeColor(width: offset.width)
                    }
                  }
              )
            }
          }
        }
        .listStyle(.plain)

      }
      else {

        Spacer()

        Image("no-chats-yet")

        Text("Hmm... no chats here yet!")
          .font(Font.titleText)
          .padding(.top, 32)

        Text("Chat a friend to get started")
          .font(Font.bodyParagraph)
          .padding(.top, 8)


        Spacer()
      }
    }
    .onReceive(chatViewModel.$chats) { chats in
      print("chats count: \(chats.count)")
      offsets = Array(repeating: CGSize.zero, count: chats.count)
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
    default:
      offsets[index] = .zero
    }
  }
}

struct ChatsListView_Previews: PreviewProvider {
  static var previews: some View {
    ChatsListView(isChatShowing: .constant(false),
                  isSettingsShowing: .constant(false))
  }
}

extension View {
  @ViewBuilder
      func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
          if condition() {
              transform(self)
          } else {
              self
          }
      }
}
