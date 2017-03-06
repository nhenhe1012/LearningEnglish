//
//  GrammarView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class GrammarView: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> GrammarView {
        return UINib(nibName: "GrammarView", bundle: nil).instantiate(withOwner: self, options: nil).first as! GrammarView
    }
}
