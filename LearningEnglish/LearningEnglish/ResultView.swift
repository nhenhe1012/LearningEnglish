//
//  ResultView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ResultView: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> ResultView {
        return UINib(nibName: "ResultView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ResultView
    }
}
