//
//  ReadView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ReadView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> ReadView {
        return UINib(nibName: "ReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ReadView
    }
}
