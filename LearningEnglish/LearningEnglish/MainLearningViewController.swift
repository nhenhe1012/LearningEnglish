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
    
    var beforeReadView: BeforeReadView?
    
    var readView: ReadView?
    
    var vocabularyView01: VocabularyView01?
    
    var vocabularyView02: VocabularyView02?
    
    var grammarView: GrammarView?
    
    var resultView: ResultView?
    
    var curTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.register(UINib(nibName: "LessionCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        handleVocabularyBtn(isHidden: true)
        
        beforeReadView = BeforeReadView.instanceFromNib()
        
        readView = ReadView.instanceFromNib()
        
        vocabularyView01 = VocabularyView01.instanceFromNib()
        
        vocabularyView02 = VocabularyView02.instanceFromNib()
        
        grammarView = GrammarView.instanceFromNib()
        
        resultView = ResultView.instanceFromNib()
        
        
        
        beforeReadView?.frame = mainContentPart.bounds
        readView?.frame = mainContentPart.bounds
        vocabularyView01?.frame = mainContentPart.bounds
        vocabularyView02?.frame = mainContentPart.bounds
        grammarView?.frame = mainContentPart.bounds
        
        
        self.mainContentPart.addSubview(beforeReadView!)
        self.mainContentPart.addSubview(readView!)
        self.mainContentPart.addSubview(vocabularyView01!)
        self.mainContentPart.addSubview(vocabularyView02!)
        self.mainContentPart.addSubview(grammarView!)
        
        hiddenAllSubView()
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if DataManager.shared.selectedLession != -1
        {
            beforeReadView?.loadData(index: DataManager.shared.selectedLession)
            readView?.loadData(index: DataManager.shared.selectedLession)
        }
        else
        {
            return
        }
        if curTab == sender.tag{
            return
        }
        setAllButtonDefault()
        hiddenAllSubView()
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
            beforeReadView?.isHidden = false
            break
        case 2:
            imgNameString = "button_Read_02.png"
            readView?.isHidden = false
            break
        case 3:
            imgNameString = "button_vocabulary_02.png"
            self.btnVocabulary12.setImage(UIImage(named: "btn_1&2_act.png"), for: .normal)
            vocabularyView01?.isHidden = false
            break
        case 4:
            imgNameString = "button_grammar_02.png"
            grammarView?.isHidden = false
            break
        case 5:
            self.btnVocabulary.setImage(UIImage(named: "button_vocabulary_02.png"), for: .normal)
            imgNameString = "btn_1&2_act.png"
            vocabularyView01?.isHidden = false
            curTab = 3
            break
        case 6:
            self.btnVocabulary.setImage(UIImage(named: "button_vocabulary_02.png"), for: .normal)
            imgNameString = "btn_3&4_act.png"
            vocabularyView02?.isHidden = false
            curTab = 3
            break
        default:
            break
        }

        sender.setImage(UIImage(named: imgNameString), for: .normal)
    }
    
    
    func hiddenAllSubView() {
        beforeReadView?.isHidden = true
        readView?.isHidden = true
        vocabularyView01?.isHidden = true
        vocabularyView02?.isHidden = true
        grammarView?.isHidden = true
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
