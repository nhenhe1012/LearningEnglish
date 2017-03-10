//
//  VocabularyView02.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

protocol VocabularyView2Delegate {
    func needPresent2Option()
}

class VocabularyView02: UIView {

    @IBOutlet weak var btn31: UIButton!
    
    @IBOutlet weak var btn32: UIButton!
    
    @IBOutlet weak var btn33: UIButton!
    
    @IBOutlet weak var btn34: UIButton!
    
    @IBOutlet weak var btn35: UIButton!

    
    
    var custom: CustomSelectViewController?
    
    var delegate: VocabularyView2Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        custom = CustomSelectViewController()
        custom?.delegate = self
        disableMultitouch()
    }
    
    func loadData(index: Int) {
        
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        if DataManager.shared.isScore {
            return
        }
        
        custom?.modalPresentationStyle = .popover
        custom?.preferredContentSize = CGSize(width: 300, height: 140)
        custom?.popoverPresentationController?.sourceView = sender
        custom?.popoverPresentationController?.sourceRect = sender.bounds
        custom?.popoverPresentationController?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        delegate?.needPresent2Option()
        custom?.defaultLocal(sender.tag)
        
    }
    
    func disableMultitouch() {
        btn31.isExclusiveTouch = true
        btn32.isExclusiveTouch = true
        btn33.isExclusiveTouch = true
        btn34.isExclusiveTouch = true
        btn35.isExclusiveTouch = true
    }
    
    class func instanceFromNib() -> VocabularyView02 {
        return UINib(nibName: "VocabularyView02", bundle: nil).instantiate(withOwner: self, options: nil).first as! VocabularyView02
    }
}

extension VocabularyView02: CustomSelectViewDelegate
{
    func didSelectButtonAt(index: Int) {
        print(index)
        custom?.dismiss(animated: false, completion: nil)
    }
}
