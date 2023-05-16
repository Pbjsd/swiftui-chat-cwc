//
//  Match.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/15/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Match: Codable, Firestorable, Hashable, Identifiable {

  @DocumentID var id: String?
  var uid: String
  var myUid: String
  var otherUid: String
}
