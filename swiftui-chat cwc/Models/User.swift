//
//  User.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 8/1/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    
    @DocumentID var id: String? 
    
    var firstname: String?
    
    var lastname: String?
    
    var phone: String?
    
    var photo: String?
    
}
