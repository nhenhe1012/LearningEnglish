//
//  CustomSelectViewController.swift
//  LearningEnglish
//
//  Created by TienNT12 on 3/9/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

protocol CustomSelectViewDelegate {
    func didSelectButtonAt(index: Int)
}

class CustomSelectViewController: UIViewController {

    var delegate: CustomSelectViewDelegate?
    
    @IBOutlet weak var btn01: UIButton!
    
    @IBOutlet weak var btn02: UIButton!
    
    @IBOutlet weak var btn03: UIButton!
    
    @IBOutlet weak var btn04: UIButton!
    
    @IBOutlet weak var btn05: UIButton!
    
    var arrFrame: [CGRect] = []
    
    var center = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        center = CGRect(x: self.view.frame.height / 2 + 17, y: self.view.frame.height - 45, width: 35, height: 35)
        arrFrame.append(btn01.frame)
        arrFrame.append(btn02.frame)
        arrFrame.append(btn03.frame)
        arrFrame.append(btn04.frame)
        arrFrame.append(btn05.frame)
    }

    
    @IBAction func btnSelectClicked(_ sender: UIButton) {
        delegate?.didSelectButtonAt(index: sender.tag)
    }
    
    
    func defaultLocal(_ mode: Int) {
        btn01.tag = 1
        btn02.tag = 2
        btn03.tag = 3
        btn04.tag = 4
        btn05.tag = 5
        
        if mode == 3
        {
            btn02.isHidden = true
            btn04.isHidden = true
            btn03.tag = 2
            btn03.setImage(UIImage(named: "dapan02.png"), for: .normal)
            btn05.tag = 3
            btn05.setImage(UIImage(named: "dapan03.png"), for: .normal)
        }
        else
        {
            btn02.isHidden = false
            btn04.isHidden = false
            btn03.setImage(UIImage(named: "dapan03.png"), for: .normal)
            btn05.setImage(UIImage(named: "dapan05.png"), for: .normal)

        }
    
        btn01.frame = center
        btn02.frame = center
        btn03.frame = center
        btn04.frame = center
        btn05.frame = center
    }
    func repairLocal() {
        UIView.animate(withDuration: 0.4) { 
            self.btn01.frame = self.arrFrame[0]
        }
        UIView.animate(withDuration: 0.5) {
            self.btn02.frame = self.arrFrame[1]
        }
        UIView.animate(withDuration: 0.6) {
            self.btn03.frame = self.arrFrame[2]
        }
        UIView.animate(withDuration: 0.7) {
            self.btn04.frame = self.arrFrame[3]
        }
        UIView.animate(withDuration: 0.8) {
            self.btn05.frame = self.arrFrame[4]
        }
    }
}
