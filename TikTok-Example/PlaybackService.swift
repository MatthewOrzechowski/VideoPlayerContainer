//
//  PlaybackService.swift
//  TikTok-Example
//
//  Created by shayanbo on 2023/6/30.
//

import Foundation
import SwiftUI
import Combine
import VideoPlayerContainer

class PlaybackService : Service {
    
    private var cancellables = [AnyCancellable]()
    
    private var observation: NSKeyValueObservation?
    
    required init(_ context: Context) {
        super.init(context)
        
        let player = context.render.player
        
        observation = player.observe(\.rate) { player, changes in
            if player.rate == 0 {
                context.plugin.present(.center, transition: .scale(scale: 1.5).combined(with: .opacity)) {
                    AnyView(
                        Image(systemName: "play.fill").resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 50, height: 50).opacity(0.5)
                    )
                }
            } else {
                context.plugin.dismiss()
            }
        }
        
        context.gesture.observe(.tap(.all)) { [weak player] event in
            guard let player = player else { return }
            
            if player.rate == 0 {
                player.play()
            } else {
                player.pause()
            }
            
        }.store(in: &cancellables)
    }
}
