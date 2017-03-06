//
//  VocabularyView01.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class VocabularyView01: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> VocabularyView01 {
        return UINib(nibName: "VocabularyView01", bundle: nil).instantiate(withOwner: self, options: nil).first as! VocabularyView01
    }
}
