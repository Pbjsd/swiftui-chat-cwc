//
//  TextHelper.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 11/9/22.
//

import Foundation

class TextHelper {
    
    static func sanitizePhoneNumber(_ phone: String) -> String {
        
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
}
