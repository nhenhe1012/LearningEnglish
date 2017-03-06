//
//  Utils.swift
//  Look and Guess a Word
//
//  Created by TienNT12 on 2/21/17.
//  Copyright © 2017 TienNT12. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class Utils{
    
    static let musicURL =  Bundle.main.url(forResource: "beat", withExtension: "mp3")!
    static let beepSoundURL =  Bundle.main.url(forResource: "button", withExtension: "wav")!
    static var winURL: URL?
    static var musicPlayer: AVAudioPlayer?
    static var beepPlayer = AVAudioPlayer()
    static var winPlayer = AVAudioPlayer()
    
    
    class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 10.0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.addClip()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func convertAttributedString(str: String) -> NSAttributedString
    {
        let trueStr = "<font face=\"Helvetica Neue\" size=\"4\">\(str)</font>"
        do {
            let attb1 = try NSAttributedString(data: trueStr.data(using: .unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            return attb1
        } catch {
            print(error)
            return NSAttributedString(string: "")
        }
    }
    
    class func readTextFile(fileName: String) -> String {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
            
            do {
                let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                return content
            } catch  {
                print(error)
            }
        }
        return ""
    }
    
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
