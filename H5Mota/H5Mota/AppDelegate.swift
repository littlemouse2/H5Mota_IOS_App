//
//  AppDelegate.swift
//  H5Mota
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

import UIKit
import FacebookCore
import FBSDKShareKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if error != nil || user == nil {
          print("Show the app's signed-out state.")
        } else {
          print("Show the app's signed-in state.")
        }
      }
    FirebaseApp.configure()
      return true
}
      
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
    ApplicationDelegate.shared.application(
        app,
        open: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
    var handled: Bool
    handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }
    return false
    //return GIDSignIn.sharedInstance.handle(url)
}
}
