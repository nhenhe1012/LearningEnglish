//
//  MainLearningViewController.swift
//  LearningEnglish
//
//  Created by Tien on 3/5/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class MainLearningViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var mainContentView: UIView!
    
    @IBOutlet weak var mainControlContent: UIView!
    
    @IBOutlet weak var mainContentPart: UIView!
    
    @IBOutlet weak var btnBeforRead: UIButton!
    
    @IBOutlet weak var btnRead: UIButton!
    
    @IBOutlet weak var btnVocabulary: UIButton!
    
    @IBOutlet weak var btnVocabulary12: UIButton!
    
    @IBOutlet weak var btnVocabulary34: UIButton!
    
    @IBOutlet weak var btnGrammar: UIButton!
    
    @IBOutlet weak var btnScore: UIButton!
    
    var curTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.register(UINib(nibName: "LessionCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        handleVocabularyBtn(isHidden: true)
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if curTab == sender.tag {
            return
        }
        setAllButtonDefault()
        var imgNameString = ""
        if(sender.tag == 3 || sender.tag == 5 || sender.tag == 6)
        {
            handleVocabularyBtn(isHidden: false)
        }
        else{
            handleVocabularyBtn(isHidden: true)
        }
        curTab = sender.tag
        switch sender.tag {
        case 1:
            imgNameString = "button_beforuread_02.png"
            break
        case 2:
            imgNameString = "button_Read_02.png"
            break
        case 3:
            imgNameString = "button_vocabulary_02.png"
            self.btnVocabulary12.setImage(UIImage(named: "btn_1&2_act.png"), for: .normal)
            break
        case 4:
            imgNameString = "button_grammar_02.png"
            break
        case 5:
            self.btnVocabulary.setImage(UIImage(named: "button_vocabulary_02.png"), for: .normal)
            imgNameString = "btn_1&2_act.png"
            curTab = 3
            break
        case 6:
            self.btnVocabulary.setImage(UIImage(named: "button_vocabulary_02.png"), for: .normal)
            imgNameString = "btn_3&4_act.png"
            curTab = 3
            break
        default:
            break
        }

        sender.setImage(UIImage(named: imgNameString), for: .normal)
        
    }
    
    @IBAction func btnScoreClicked(_ sender: AnyObject) {
        
    }
    
    func handleVocabularyBtn(isHidden: Bool)  {
        self.btnVocabulary12.isHidden = isHidden
        self.btnVocabulary34.isHidden = isHidden
    }
    
    func setAllButtonDefault() {
        self.btnBeforRead.setImage(UIImage(named: "button_beforuread_01.png"), for: .normal)
        self.btnRead.setImage(UIImage(named: "button_Read_01.png"), for: .normal)
        self.btnVocabulary.setImage(UIImage(named: "button_vocabulary_01.png"), for: .normal)
        self.btnVocabulary12.setImage(UIImage(named: "btn_1&2_nor.png"), for: .normal)
        self.btnVocabulary34.setImage(UIImage(named: "btn_3&4_nor.png"), for: .normal)
        self.btnGrammar.setImage(UIImage(named: "button_grammar_01.png"), for: .normal)
    }
}

extension MainLearningViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.arrLession.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LessionCell
        
        cell.setupView(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == DataManager.shared.selectedLession {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! LessionCell
        DataManager.shared.selectedLession = indexPath.row
        
        btnClicked(btnBeforRead)
        
        cell.cellSelect()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? LessionCell
        cell?.cellDeSelect()
    }
    
}
