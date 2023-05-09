//
//  User.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 8/1/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?

  var uid: String?
    
    var firstname: String?
    
    var lastname: String?
    
    var phone: String?
    
    var photo: String?
    
    var isactive: Bool = true

    var gender: String?

    var age: String?

    var occupation: String?

    var hobbies: String?

    var bio: String?

    var iamlookingfor: String?
    
}
