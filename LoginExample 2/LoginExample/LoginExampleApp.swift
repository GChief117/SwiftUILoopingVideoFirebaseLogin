//
//  LoginExampleApp.swift
//  LoginExample
//
//  Created by Gunnar Beck on 3/11/25.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct LoginExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("log_Status") var log_Status = false
    
    var body: some Scene {
        WindowGroup {
            if log_Status {
                ContentView()
            } else {
                SignInPageView(videoName: "sun")
                    .onOpenURL{ url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
            }
        }
    }
}
