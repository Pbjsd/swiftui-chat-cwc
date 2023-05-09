//
//  ProfileService.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/3/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProfileService: ObservableObject {

  @Published var currentUser: User?

  @Published var otherUsers: [User] = []

  func fetchCurrentUser() {
    guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
    Firestore.firestore().collection("users").document(currentUserUid).getDocument(as: User.self) { result in
      switch result {
      case .success(let user):
        self.currentUser = user
      case .failure(let failure):
        print(failure.localizedDescription)
      }
    }
  }

  @MainActor
  func fetchOtherUsers() async throws {
    let snapshot = try await Firestore.firestore().collection("users").getDocuments()
    let documents = snapshot.documents
    print("count: \(documents.count)")
    let objects = try documents.compactMap { document in
      try document.data(as: User.self)
    }
    var filteredUsers: [User] = []
    guard let currentUser else { return }
    print(123)
    objects.forEach { user in
      if user.uid != currentUser.uid {
        filteredUsers.append(user)
      }
    }
    otherUsers = filteredUsers
  }

}
