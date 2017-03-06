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

        beforeYouReadTextView.attributedText = convertAttributedString(str: DataManager.shared.arrLession[index].bfTheRead)
        newVocabularyTextView.attributedText = convertAttributedString(str: DataManager.shared.arrLession[index].nVocabulary)
        idiomsTextView.attributedText = convertAttributedString(str: DataManager.shared.arrLession[index].iDiom)
    }
    
    func convertAttributedString(str: String) -> NSAttributedString
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
    
    class func instanceFromNib() -> BeforeReadView {
        return UINib(nibName: "BeforeReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! BeforeReadView
    }

}
