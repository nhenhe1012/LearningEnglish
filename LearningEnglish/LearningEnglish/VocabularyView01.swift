//
//  VocabularyView01.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

protocol VocabularyViewDelegate {
    func needPresentOption()
}

class VocabularyView01: UIView {

    
    @IBOutlet weak var btn11: UIButton!
    
    @IBOutlet weak var btn12: UIButton!
    
    @IBOutlet weak var btn13: UIButton!
    
    @IBOutlet weak var btn21: UIButton!
    
    @IBOutlet weak var btn22: UIButton!
    
    @IBOutlet weak var btn23: UIButton!
    
    @IBOutlet weak var btn24: UIButton!
    
    @IBOutlet weak var btn25: UIButton!
    
    @IBOutlet weak var contentVoca1: UIView!
    
    @IBOutlet weak var contentVoca2: UIView!
    
    var formatSelectedStr: String = "<font color=\"#007eff\">%@</font>"
    
    var curStr: String = ""
    
    var arrLabelVoca1: [UILabel] = []
    
    var arrLabelVoca2: [UILabel] = []

    
    var custom: CustomSelectViewController?
    
    var delegate: VocabularyViewDelegate?
    
    @IBAction func btnClick(_ sender: UIButton) {

        if DataManager.shared.isScore {
            return
        }
        curStr = (sender.titleLabel?.text)!
        custom?.modalPresentationStyle = .popover
        custom?.preferredContentSize = CGSize(width: 300, height: 140)
        custom?.popoverPresentationController?.sourceView = sender
        custom?.popoverPresentationController?.sourceRect = sender.bounds
        custom?.popoverPresentationController?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        delegate?.needPresentOption()
        custom?.defaultLocal(sender.tag)

    }
    
    func loadData(index: Int) {
        
        loadDataToVoca1()
        loadDataToVoca2()
    }
    
    func loadDataToVoca1()
    {
        for i in 0...2 {
            
            switch i {
            case 0:
                btn11.setTitle(DataManager.shared.arrVoca1[i].dapAn, for: .normal)
                break
            case 1:
                btn12.setTitle(DataManager.shared.arrVoca1[i].dapAn, for: .normal)
                break
            case 2:
                btn13.setTitle(DataManager.shared.arrVoca1[i].dapAn, for: .normal)
                break
            default:
                
                break
            }
            let yLocation = i * Int(contentVoca1.bounds.height / 3)
            arrLabelVoca1[i].frame = CGRect(x: 40, y: 15 + yLocation, width: Int(contentVoca1.bounds.width - 60), height: 41)
            arrLabelVoca1[i].attributedText = getCurrentChooseString(curAnswer: i, noiDung: DataManager.shared.arrVoca1[i].noiDung, daChon: DataManager.shared.arrVoca1[i].daChon, index: i + 1)
        }
    }
    
    func loadDataToVoca2()
    {
        for i in 0...4 {
            
            switch i {
            case 0:
                btn21.setTitle(DataManager.shared.arrVoca2[i].dapAn, for: .normal)
                break
            case 1:
                btn22.setTitle(DataManager.shared.arrVoca2[i].dapAn, for: .normal)
                break
            case 2:
                btn23.setTitle(DataManager.shared.arrVoca2[i].dapAn, for: .normal)
                break
            case 3:
                btn24.setTitle(DataManager.shared.arrVoca2[i].dapAn, for: .normal)
                break
            case 4:
                btn25.setTitle(DataManager.shared.arrVoca2[i].dapAn, for: .normal)
                break
            default:
                
                break
            }
            let yLocation = i * Int(contentVoca2.bounds.height / 5)
            arrLabelVoca2[i].frame = CGRect(x: 40, y: 7 + yLocation, width: Int(contentVoca2.bounds.width - 60), height: 41)
            arrLabelVoca2[i].attributedText =  getCurrentChooseString(curAnswer: i, noiDung: DataManager.shared.arrVoca2[i].noiDung, daChon: DataManager.shared.arrVoca2[i].daChon, index: i + 1)
        }
    }

    func getCurrentChooseString(curAnswer: Int, noiDung: String, daChon: String, index: Int) -> NSAttributedString {
        let string = Utils.convertAttributedString(str: String(format: "\(index)) \(noiDung)", String(format: formatSelectedStr, " \(daChon)")))
        return (daChon != "") ? string: NSAttributedString(string: "\(index)) \(String(format:  noiDung, "______"))")
    }
    func disableMultitouch() {
        btn11.isExclusiveTouch = true
        btn12.isExclusiveTouch = true
        btn13.isExclusiveTouch = true
        btn21.isExclusiveTouch = true
        btn22.isExclusiveTouch = true
        btn23.isExclusiveTouch = true
        btn24.isExclusiveTouch = true
        btn25.isExclusiveTouch = true
    }
    
    func addViewForVocabulary() {
        contentVoca1.layoutIfNeeded()
        contentVoca1.layoutIfNeeded()
        for view in contentVoca1.subviews{
            view.removeFromSuperview()
        }
        for _ in 0...2 {

            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            lbl.numberOfLines = 2
            arrLabelVoca1.append(lbl)
            contentVoca1.addSubview(lbl)
        }
        
        for view in contentVoca2.subviews{
            view.removeFromSuperview()
        }
        for _ in 0...4 {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            lbl.numberOfLines = 2
            arrLabelVoca2.append(lbl)
            contentVoca2.addSubview(lbl)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        custom = CustomSelectViewController()
        custom?.delegate = self
        disableMultitouch()
    }
    
    
    class func instanceFromNib() -> VocabularyView01 {
        return UINib(nibName: "VocabularyView01", bundle: nil).instantiate(withOwner: self, options: nil).first as! VocabularyView01
    }
}



extension VocabularyView01: CustomSelectViewDelegate
{
    func didSelectButtonAt(index: Int) {
        print(index, curStr)
        custom?.dismiss(animated: false, completion: nil)
    }
}
