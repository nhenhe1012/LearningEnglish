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
    
    @IBOutlet weak var btnPre: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnA: UIButton!
    
    @IBOutlet weak var btnB: UIButton!
    
    @IBOutlet weak var btnC: UIButton!
    
    @IBOutlet weak var btnD: UIButton!
    
    @IBOutlet weak var lblNoiDung: UILabel!
    
    @IBOutlet weak var lblA: UILabel!
    
    @IBOutlet weak var lblB: UILabel!
    
    @IBOutlet weak var lblC: UILabel!
    
    @IBOutlet weak var lblD: UILabel!
    
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.setThumbImage(Utils.getImageWithColor(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), size: CGSize(width: 10, height: 10)), for: .normal)
        Utils.delegate = self
    }
    
    @IBAction func btnStartClicked(_ sender: UIButton) {
        DataManager.shared.isPlayingSound = !DataManager.shared.isPlayingSound
        let img:String = (DataManager.shared.isPlayingSound) ? "media_ico_pause.png" : "media_ico.png"
        
        DataManager.shared.isPlayingSound ? Utils.playBackgroundMusic() : Utils.pauseBackgoundMusic()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleDataLayout), userInfo: nil, repeats: true)
     
        sender.setImage(UIImage(named: img), for: .normal)

    }
    
    func handleDataLayout()  {
        
        lblCurTime.text = String(format: "%02d:%02d", Int((Utils.musicPlayer?.currentTime)!)/60, Int((Utils.musicPlayer?.currentTime)!)%60)
        lblDurTime.text = String(format: "%02d:%02d", Int((Utils.musicPlayer?.duration)!)/60, Int((Utils.musicPlayer?.duration)!)%60)
        slider.value = Float((Utils.musicPlayer?.currentTime)!) / Float((Utils.musicPlayer?.duration)!)
        if(Int((Utils.musicPlayer?.currentTime)!) >= Int((Utils.musicPlayer?.duration)!))
        {
            timer?.invalidate()
            DataManager.shared.isPlayingSound = false
            slider.value = 0
            lblCurTime.text = "00:00"
            let img:String = (DataManager.shared.isPlayingSound) ? "media_ico_pause.png" : "media_ico.png"
            //Utils.pauseBackgoundMusic()
            btnStart.setImage(UIImage(named: img), for: .normal)
        }

    }
    
    
    func loadData(index: Int)  {
        
        let number = DataManager.shared.selectedLession + 1 < 10 ? "0\(DataManager.shared.selectedLession + 1)" : "\(DataManager.shared.selectedLession + 1)"
        Utils.initAudio(name: "L2-Chapter\(number)")
        handleDataLayout()
        fillDataToReadAnswer()
        let img:String = (DataManager.shared.isPlayingSound) ? "media_ico_pause.png" : "media_ico.png"
        btnStart.setImage(UIImage(named: img), for: .normal)
        textViewBaiDoc.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index + 1)_read"))
        textViewFocus.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index + 1)_tumoi"))
        lblLessionName.text = DataManager.shared.arrLession[index].tenBaiLam
    }
    
    @IBAction func btnPagingClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            btnNext.isEnabled = true
            if DataManager.shared.curReadAnswer > 0
            {
                DataManager.shared.curReadAnswer -= 1
            }
            break
        case 1:
            btnPre.isEnabled = true
            if DataManager.shared.curReadAnswer < DataManager.shared.arrReadQuestion.count
            {
                DataManager.shared.curReadAnswer += 1
            }
            break
        default:
            break
        }
        fillDataToReadAnswer()
    }
    
    @IBAction func btnAnswerClicked(_ sender: UIButton) {
        if DataManager.shared.isScore {
            return
        }
        selectedButton(dachon: sender.tag)
        DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].daChon = sender.tag
    }
    
    func selectedButton(dachon: Int)  {
        btnA.setImage(UIImage(named: "btn_A_01.png"), for: .normal)
        btnB.setImage(UIImage(named: "btn_B_01.png"), for: .normal)
        btnC.setImage(UIImage(named: "btn_C_01.png"), for: .normal)
        btnD.setImage(UIImage(named: "btn_D_01.png"), for: .normal)
        
        switch dachon {
        case 1:
            btnA.setImage(UIImage(named: "btn_A_02.png"), for: .normal)
            break
        case 2:
            btnB.setImage(UIImage(named: "btn_B_02.png"), for: .normal)
            break
        case 3:
            btnC.setImage(UIImage(named: "btn_C_02.png"), for: .normal)
            break
        case 4:
            btnD.setImage(UIImage(named: "btn_D_02.png"), for: .normal)
            break
        default:
            break
        }
    }
    
    func fillDataToReadAnswer() {
        
        btnPre.isEnabled = (DataManager.shared.curReadAnswer == 0) ? false : true
        btnNext.isEnabled = (DataManager.shared.curReadAnswer == DataManager.shared.arrReadQuestion.count - 1) ? false : true
        lblNoiDung.text =  "\(DataManager.shared.curReadAnswer + 1)) \(DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].noiDung)"
        lblA.text = DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].dapAnA
        lblB.text = DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].dapAnB
        lblC.text = DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].dapAnC
        lblD.text = DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].dapAnD
        
        selectedButton(dachon: DataManager.shared.arrReadQuestion[DataManager.shared.curReadAnswer].daChon)
    }
    
    class func instanceFromNib() -> ReadView {
        return UINib(nibName: "ReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ReadView
    }
}
extension ReadView: UtilsDelegate
{
    func funcDidPause() {
        DataManager.shared.isPlayingSound = false
        timer?.invalidate()
        let img:String = (DataManager.shared.isPlayingSound) ? "media_ico_pause.png" : "media_ico.png"
        btnStart.setImage(UIImage(named: img), for: .normal)
    }
}
