//
//  MatchesView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 5/16/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MatchesView: View {

  @EnvironmentObject private var profileService: ProfileService

  @State private var matches: [Match] = []

    var body: some View {
      List {
        ForEach(matches) { match in
          VStack {
            Text(match.myUid)
            Text(match.otherUid)
          }
        }
      }
      .onAppear {
        fetchMatches()
      }
    }

  func fetchMatches() {
    guard let myUid = profileService.currentUser?.uid else { return }
    let queryPredicates: [QueryPredicate] = [.isEqualTo("myUid", myUid)]
    let queryPredicates2: [QueryPredicate] = [.isEqualTo("otherUid", myUid)]
    Task {
      do {
        let matches1: [Match] = try await FirestoreContext.query(collectionPath: "matches", predicates: queryPredicates)
        let matches2: [Match] = try await FirestoreContext.query(collectionPath: "matches", predicates: queryPredicates2)
        let matches = matches1 + matches2
        self.matches = matches.sorted(by: { m0, m1 in
          m0.createdAt.dateValue() < m1.createdAt.dateValue()
        })
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
