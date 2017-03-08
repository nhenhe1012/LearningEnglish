//
//  LessionCell.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class LessionCell: UITableViewCell {

    @IBOutlet weak var imgBook: UIImageView!
    
    @IBOutlet weak var lblChapter: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var contentSubView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = self.contentView.backgroundColor
        self.contentSubView.layer.cornerRadius = 15
        self.contentSubView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 15
    }

    func cellSelect() {
     //   imgBook?.image = UIImage(named: "book_ico_active.png")
        lblChapter.textColor = .blue
    }
    func cellDeSelect() {
       // imgBook?.image = UIImage(named: "book_ico_normal.png")
        lblChapter.textColor = .white
    }
    
    func setupView(index: Int) {
        DataManager.shared.selectedLession == index ? cellSelect() : cellDeSelect()
        lblChapter.text = String("Chapter \(DataManager.shared.arrLession[index].maLession)")
        lblName.text = DataManager.shared.arrLession[index].tenBaiLam
    }
}
