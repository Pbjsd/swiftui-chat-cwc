//
//  SettingsViewModel.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 3/16/23.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @AppStorage(Constants.DarkModeKey) var isDarkMode = false
    
    var databaseService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        
        // Call the database service
        databaseService.deactivateAccount {
            
            // Deactivation is complete
            completion()
        }
    }
    
}
