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
    
    
    var custom: CustomSelectViewController?
    
    var delegate: VocabularyViewDelegate?
    
    @IBAction func btnClick(_ sender: UIButton) {

        if DataManager.shared.isScore {
            return
        }
        
        custom?.modalPresentationStyle = .popover
        custom?.preferredContentSize = CGSize(width: 300, height: 140)
        custom?.popoverPresentationController?.sourceView = sender
        custom?.popoverPresentationController?.sourceRect = sender.bounds
        custom?.popoverPresentationController?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        delegate?.needPresentOption()
        custom?.defaultLocal()

    }
    
    func loadData(index: Int) {
        
        addViewToVoca1()
    }
    
    func addViewToVoca1()
    {
        
        for view in contentVoca1.subviews{
            view.removeFromSuperview()
        }
        for i in 0...2 {
            let yLocation = i * Int(contentVoca1.bounds.height / 3.5)
            
            let lbl = UILabel(frame: CGRect(x: 40, y: 15 + yLocation, width: Int(contentVoca1.bounds.width - 60), height: 41))
            lbl.numberOfLines = 2
            lbl.text = "\(i + 1)) \(DataManager.shared.arrVoca1[i].noiDung)"
        
            contentVoca1.addSubview(lbl)
        }
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
        print(index)
    }
}
