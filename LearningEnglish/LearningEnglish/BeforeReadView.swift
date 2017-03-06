//
//  BeforeReadView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class BeforeReadView: UIView {

    @IBOutlet weak var beforeYouReadTextView: UITextView!
    
    @IBOutlet weak var newVocabularyTextView: UITextView!
    
    @IBOutlet weak var idiomsTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loadData(index: Int) {

        beforeYouReadTextView.attributedText = Utils.convertAttributedString(str: DataManager.shared.arrLession[index].bfTheRead)
        newVocabularyTextView.attributedText = Utils.convertAttributedString(str: DataManager.shared.arrLession[index].nVocabulary)
        idiomsTextView.attributedText = Utils.convertAttributedString(str: DataManager.shared.arrLession[index].iDiom)
    }
    
    
    
    class func instanceFromNib() -> BeforeReadView {
        return UINib(nibName: "BeforeReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! BeforeReadView
    }

}
