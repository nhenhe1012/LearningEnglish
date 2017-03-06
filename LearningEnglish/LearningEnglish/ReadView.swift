//
//  ReadView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ReadView: UIView {

    @IBOutlet weak var lblLessionName: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var lblCurTime: UILabel!
    
    @IBOutlet weak var lblDurTime: UILabel!
    
    @IBOutlet weak var textViewBaiDoc: UITextView!
    
    @IBOutlet weak var textViewFocus: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.setThumbImage(Utils.getImageWithColor(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), size: CGSize(width: 10, height: 10)), for: .normal)
    }
    
    
    func loadData(index: Int)  {
        
        
        textViewBaiDoc.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index)_read"))
        textViewFocus.attributedText = Utils.convertAttributedString(str: Utils.readTextFile(fileName: "\(index)_tumoi"))
        lblLessionName.text = DataManager.shared.arrLession[index].tenBaiLam
    }
    
    class func instanceFromNib() -> ReadView {
        return UINib(nibName: "ReadView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ReadView
    }
}
