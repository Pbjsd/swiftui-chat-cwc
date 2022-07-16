//
//  AppDelegate.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/15/22.
//

import Foundation
import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
