//
//  ChatsListView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 1/21/23.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        
        if chatViewModel.chats.count > 0 {
            
            List(chatViewModel.chats) { chat in
                
                Text(chat.id ?? "empty chat id")
                
            }
            
        }
        else {
            Text("No chats")
        }
        
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
    }
}
