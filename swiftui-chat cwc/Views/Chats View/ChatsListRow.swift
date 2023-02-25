//
//  ChatsListRow.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 2/25/23.
//

import SwiftUI

struct ChatsListRow: View {
    
    var chat: Chat
    
    var otherParticipants: [User]?
    
    var body: some View {
        
        HStack (spacing: 24) {
            
            // Assume at least 1 other participant in the chat
            let participant = otherParticipants?.first
            
            // Profile Image of participants
            if participant != nil {
                ProfilePicView(user: participant!)
            }
            
            VStack (alignment: .leading, spacing: 4) {
                // Name
                Text(participant == nil ? "Unknown" :
                        "\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // last message
                Text(chat.lastmsg ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
                     
            // Timestamp
            Text(chat.updated == nil ? "" :
                        DateHelper.chatTimestampFrom(date: chat.updated!))
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
        }
                     
    }
}


