//
//  DateHelper.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 2/21/23.
//

import Foundation

class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
           
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
    
}
