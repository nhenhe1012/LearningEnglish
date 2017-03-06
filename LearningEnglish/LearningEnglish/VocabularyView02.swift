//
//  VocabularyView02.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class VocabularyView02: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> VocabularyView02 {
        return UINib(nibName: "VocabularyView02", bundle: nil).instantiate(withOwner: self, options: nil).first as! VocabularyView02
    }
}
