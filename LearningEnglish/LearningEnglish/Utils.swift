//
//  Utils.swift
//  Look and Guess a Word
//
//  Created by TienNT12 on 2/21/17.
//  Copyright © 2017 TienNT12. All rights reserved.
//

import Foundation
import AVFoundation

class Utils{
    
    static let musicURL =  Bundle.main.url(forResource: "beat", withExtension: "mp3")!
    static let beepSoundURL =  Bundle.main.url(forResource: "button", withExtension: "wav")!
    static var winURL: URL?
    static var musicPlayer: AVAudioPlayer?
    static var beepPlayer = AVAudioPlayer()
    static var winPlayer = AVAudioPlayer()
    
    class func playSound() {
        
//        if(DataManager.shared.setting.isSound)
//        {
            do {
                try beepPlayer = AVAudioPlayer(contentsOf: beepSoundURL)
            } catch {
                
            }
            beepPlayer.prepareToPlay()
            beepPlayer.play()
      //  }
    }
    
    class func playResultSound(isWin: Bool) {
//        if(DataManager.shared.setting.isSound)
//        {
            var str = "game-over"
            if(isWin)
            {
                str = "game-win"
            }
            winURL = Bundle.main.url(forResource: str, withExtension: "mp3")!
            do {
                try winPlayer = AVAudioPlayer(contentsOf: winURL!)
            } catch {
                
            }
            winPlayer.prepareToPlay()
            winPlayer.play()
       // }
    }
    
    class func playBackgroundMusic() {
//        if(musicPlayer == nil)
//        {
            do {
                try musicPlayer = AVAudioPlayer(contentsOf: musicURL)
            } catch {
                
            }
//        }
//        if(DataManager.shared.setting.isMusic)
//        {
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.play()
//        }
//        else
//        {
//            musicPlayer?.stop()
//        }
    }
    class func pauseBackgoundMusic() {
        musicPlayer?.stop()
    }
}
