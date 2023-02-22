//
//  ChatViewModel.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 2/7/23.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
    var databaseService = DatabaseService()
    
    init() {
        
        // Retrieve chats when ChatViewModel is created
        getChats()
    }
    
    func getChats() {
        
        // Use the database service to retrieve the chats
        databaseService.getAllChats { chats in
            
            // Set the retrieved data to the chats property
            self.chats = chats
        }
    }
    
    func getMessages() {
        
        // Check that there's a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.getAllMessages(chat: selectedChat!) { msgs in
            
            // Set returned messages to property
            self.messages = msgs
        }
        
    }
    
    func sendMessage(msg: String) {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.sendMessage(msg: msg, chat: selectedChat!)
        
    }
    
    /// Tasks in a list of user ids, removes the user from that list and returns the remaining ids
    func getParticipantIds() -> [String] {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return [String]()
        }
        
        // Filter out the user's id 
        let ids = selectedChat!.participantids.filter { id in
            id != AuthViewModel.getLoggedInUserId()
        }
        
        return ids
    }
}
