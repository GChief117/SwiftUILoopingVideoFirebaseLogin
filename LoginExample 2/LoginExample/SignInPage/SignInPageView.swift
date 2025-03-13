//
//  SignInPageView.swift
//  LoginExample
//
//  Created by Gunnar Beck on 3/11/25.
//

import SwiftUI
import AuthenticationServices
import Firebase
import FirebaseAuth
import AVFoundation
import GoogleSignIn

struct SignInPageView: View {
    
    //track to see whether the sign in page is loading
    @State var isLoading: Bool = false
    
    //initialize the video player
    @State private var player = AVQueuePlayer()
    
    //store the video name
    private let videoName: String
    
    //initlize the video name
    
    public init(videoName: String) {
        self.videoName = videoName
    }
    
    
    var body: some View {
        ZStack {
            
            //Background Video layer
            //Use GeometryReader to adjust the video size dynamically
            //PLayerView is going to load and play the video
            GeometryReader { geo in
                PlayerView(videoName: videoName, player: player)
                    .onAppear() {
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        player.play()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        player.play()
                    }
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()

            VStack (spacing: 10) {
                VStack(alignment: .center, spacing: 15) {
                    Text("MyLoginExample")
                        .font(.custom("Times New Roman", size: 36))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.bottom)
                    
                    SignInWithApple()
                    GoogleSignInButtonView()
                        .padding(.horizontal, 60)
                }
                
                VStack {
                    Link(destination: URL(string: "https://gunnarbnelson.com")!) {
                        VStack {
                            Text("By Signing In")
                            Text("You Agree To Our Terms and Conditions.")
                        }
                        .foregroundColor(.white)
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    SignInPageView(videoName: "sun")
}
