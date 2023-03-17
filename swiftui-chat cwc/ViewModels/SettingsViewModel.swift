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
    
}
