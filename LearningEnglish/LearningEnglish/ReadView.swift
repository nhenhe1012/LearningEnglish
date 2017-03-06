//
//  ReadView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ReadView: UIView {

    @IBOutlet weak var lblLessionName: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var lblCurTime: UILabel!
    
    @IBOutlet weak var lblDurTime: UILabel!
    
    @IBOutlet weak var textViewBaiDoc: UITextView!
    
    @IBOutlet weak var textViewFocus: UITextView!
    
    @IBOutlet weak var btnStart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.setThumbImage(Utils.getImageWithColor(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), size: CGSize(width: 10, height: 10)), for: .normal)
    }
    
    @IBAction func btnStartClicked(_ sender: UIButton) {
        
        let img:String = (DataManager.shared.isPlayingSound) ? "media_ico.png" : "media_ico_pause.png"
        let number = DataManager.shared.selectedLession + 1 < 10 ? "0\(DataManager.shared.selectedLession + 1)" : "\(DataManager.shared.selectedLession + 1)"

        !DataManager.shared.isPlayingSound ? Utils.playBackgroundMusic(name: "L2-Chapter\(number)") : Utils.pauseBackgoundMusic()
        sender.setImage(UIImage(named: img), for: .normal)
        DataManager.shared.isPlayingSound = !DataManager.shared.isPlayingSound
    }
    
    
    func loadData(index: Int)  {
        let img:String = (DataManager.shared.isPlayingSound) ? "media_ico.png" : "media_ico_pause.png"
        btnStart.setImage(UIImage(named: img), for: .normal)
        textViewBaiDoc.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index)_read"))
        textViewFocus.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index)_tumoi"))
        lblLessionName.text = DataManager.shared.arrLession[index].tenBaiLam
    }
    
    class func instanceFromNib() -> ReadView {
        return UINib(nibName: "ReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ReadView
    }
}
