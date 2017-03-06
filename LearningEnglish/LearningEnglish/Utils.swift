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
    
    static var musicURL:URL?
    static var musicPlayer: AVAudioPlayer?
    
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
    
    class func playBackgroundMusic(name: String) {
        musicURL = Bundle.main.url(forResource: name, withExtension: "mp3")!
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: musicURL!)
        } catch {
            
        }
        //musicPlayer?.numberOfLoops = -1
        musicPlayer?.play()
    }
    class func pauseBackgoundMusic() {
        musicPlayer?.stop()
    }
}
