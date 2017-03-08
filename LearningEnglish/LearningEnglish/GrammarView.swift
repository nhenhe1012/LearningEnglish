//
//  GrammarView.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class GrammarView: UIView {
    
    @IBOutlet weak var contentAnswer: UIView!
    
    @IBOutlet weak var grammarTextView: UITextView!
    
    var grammarStr: String = ""
    
    var formatSelectedStr: String = "<font color=\"#007eff\">%@</font>"
    
    var listAggument:[Int:String] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func addViewToAnswer() {
        
        for view in contentAnswer.subviews{
            view.removeFromSuperview()
        }
        for i in 0...9 {
            let yLocation = i * Int(contentAnswer.bounds.height / 10)
            
            let lbl = UILabel(frame: CGRect(x: 20, y: 5 + yLocation, width: 40, height: 30))
            lbl.text = "\(i + 1))"
            lbl.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            contentAnswer.addSubview(lbl)
            
            for x in 0...3
            {
                var bonus = ""
                var answer = ""
                switch x {
                case 0:
                    bonus = "(a)"
                    answer = DataManager.shared.arrNguPhap[i].dapAnA
                    break
                case 1:
                    bonus = "(b)"
                    answer = DataManager.shared.arrNguPhap[i].dapAnB
                    break
                case 2:
                    bonus = "(c)"
                    answer = DataManager.shared.arrNguPhap[i].dapAnC
                    break
                case 3:
                    bonus = "(d)"
                    answer = DataManager.shared.arrNguPhap[i].dapAnD
                    break
                default:
                    break
                }
                let xLocation = x * 170
                let btn = UIButton(frame: CGRect(x: 70 + xLocation, y: 5 + yLocation, width: 170, height: 30))
                btn.tag = i * 10 + x
                btn.contentHorizontalAlignment = .left
                btn.setTitle("\(bonus)\(answer)", for: .normal)
                btn.addTarget(self, action: #selector(btnAnswerClicked(_:)), for: .touchUpInside)
                contentAnswer.addSubview(btn)
            }
        }
    }
    func repairData()  {
        for i in 1...10 {
            listAggument[i] = getCurrentChooseString(curAnswer: i - 1)
        }
    }
    func getCurrentChooseString(curAnswer: Int) -> String {
        
        var str = " ______"
        let dachon = DataManager.shared.arrNguPhap[curAnswer].daChon
        
        switch dachon - 1 {
        case 0:
            str = DataManager.shared.arrNguPhap[curAnswer].dapAnA
            break
        case 1:
            str = DataManager.shared.arrNguPhap[curAnswer].dapAnB
            break
        case 2:
            str = DataManager.shared.arrNguPhap[curAnswer].dapAnC
            break
        case 3:
            str = DataManager.shared.arrNguPhap[curAnswer].dapAnD
            break
        default:
            break
        }
        return (str != " ______") ? String(format: formatSelectedStr, " \(str)") : str
    }
    
    func btnAnswerClicked(_ sender: UIButton) {
        if DataManager.shared.isScore {
            return
        }
        
        let curAnswer = sender.tag/10
        let curChoose = sender.tag%10

        DataManager.shared.arrNguPhap[curAnswer].daChon = curChoose + 1

        listAggument[sender.tag/10 + 1] = getCurrentChooseString(curAnswer: curAnswer)
        
        grammarTextView.attributedText = Utils.convertAttributedString(str: fillListAggumentToText(DataManager.shared.selectedLession))
    }
    
    func loadData(index: Int) {
        repairData()
        grammarTextView.attributedText = Utils.convertAttributedString(str: fillListAggumentToText(index))
        addViewToAnswer()
    }
    
    func fillListAggumentToText(_ index: Int) -> String {
        return String(format: Utils.readTextFile(fileName: "\(index + 1)_nguphap"), listAggument[1]!,listAggument[2]!,listAggument[3]!,listAggument[4]!,listAggument[5]!,listAggument[6]!,listAggument[7]!,listAggument[8]!,listAggument[9]!,listAggument[10]!)
    }
    
    class func instanceFromNib() -> GrammarView {
        return UINib(nibName: "GrammarView", bundle: nil).instantiate(withOwner: self, options: nil).first as! GrammarView
    }
}
