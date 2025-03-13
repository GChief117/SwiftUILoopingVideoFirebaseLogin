//
//  LoopingUI.swift
//  LoginExample
//
//  Created by Gunnar Beck on 3/11/25.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation

//Purpose, we will create a wrapper called PlayerView, to allow looping of videos/our video to play in the background for SwiftUI
struct PlayerView: UIViewRepresentable{
    private let videoName: String //Store the name of the video file
    private let player: AVQueuePlayer //Responsible for the video playback
    
    //initialize to set the video name and player
    init(videoName: String, player: AVQueuePlayer) {
        self.videoName = videoName
        self.player = player
    }
    
    //Create and return a LoopingPlayerUIView (a class we will make and use from the UIKit library using UIView for looping video playback
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(videoName: videoName, player: player)
    }
    
    //edge case to update the UIView, in case we need to have other videos played-the reason why
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {}
}

//class LoopingPlayerUIView
class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer() //handles rendering of video content
    private var playerLooper: AVPlayerLooper? //handles continuous looping playback for the video
    
    //we need to initialize our class with the necessary paraemters and an edge case when not using a storyboard
    
    //Initializer 1: This required for using this class when we are not using a storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     The initializer for the class"
     -videoName: The name o the video file we will call in the app bundle
     -player AVQueueplayer instace is called to play the video
     -videoGravity: Specify how the video si displayed
     */
    init(videoName: String, player: AVQueuePlayer, videoGravity: AVLayerVideoGravity = .resizeAspectFill) {
        
        //this calls the UIView's initializer
        super.init(frame: .zero)
        
        guard let fileURl = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {return}
        
        let asset = AVAsset(url: fileURl)
        
        let item = AVPlayerItem(asset: asset)
        
        //mute the playervideo
        player.isMuted = true
        
        //allow the video to be rendered and displayed
        playerLayer.player = player
        playerLayer.videoGravity = videoGravity
        
        //establis the view's heiarchy
        layer.addSublayer(playerLayer)
        
        //create a looping player with the AVQueuePLayer and AVPLayerItem
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }
    
    //adjust the player layer's frame
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds //here we see the video filling the view's bounds regardless of device and its aspect ratios        
        }
}
