//
//  ContentView.swift
//  LoginExample
//
//  Created by Gunnar Beck on 3/11/25.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

struct ContentView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        VStack {
            Button(action: logout) {
                Text("Log Out")
            }
        }
        .padding()
    }
    
    func logout() {
        do {
            //Google
            if GIDSignIn.sharedInstance.currentUser != nil {
                GIDSignIn.sharedInstance.signOut()
            }
            
            //just in case with firebase
            try Auth.auth().signOut()
            
            //Apple
            if let _ = UserDefaults.standard.string(forKey: "appleUserID") {
                UserDefaults.standard.removeObject(forKey: "appleUserID")
            }
            
            log_Status = false
            
            print("User is logged out")
        }
        catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
