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
    
    @IBOutlet weak var btnPre: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var viewPaging: UIView!
    
    @IBOutlet weak var paging: UIPageControl!
    
    var beforeReadView: BeforeReadView?
    
    var readView: ReadView?
    
    var vocabularyView01: VocabularyView01?
    
    var vocabularyView02: VocabularyView02?
    
    var grammarView: GrammarView?
    
    var resultView: ResultView?
    
    var curTab: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        btnBeforRead.isExclusiveTouch = true
        btnRead.isExclusiveTouch = true
        btnVocabulary.isExclusiveTouch = true
        btnVocabulary12.isExclusiveTouch = true
        btnVocabulary34.isExclusiveTouch = true
        btnGrammar.isExclusiveTouch = true
        btnScore.isExclusiveTouch = true
        btnPre.isExclusiveTouch = true
        btnNext.isExclusiveTouch = true
        
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
        
        viewPaging.isHidden = true
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if DataManager.shared.selectedLession == -1{
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
        switch sender.tag {
        case 1:
            imgNameString = "button_beforuread_02.png"
            beforeReadView?.loadData(index: DataManager.shared.selectedLession)
            beforeReadView?.isHidden = false
            btnPre.isEnabled = false
            btnNext.isEnabled = true
            curTab = 1
            break
        case 2:
            imgNameString = "button_Read_02.png"
            readView?.loadData(index: DataManager.shared.selectedLession)
            readView?.isHidden = false
            btnPre.isEnabled = true
            btnNext.isEnabled = true
            curTab = 2
            break
        case 3:
            imgNameString = "button_vocabulary_02.png"
            self.btnVocabulary12.setImage(UIImage(named: "btn_1&2_act.png"), for: .normal)
            vocabularyView01?.isHidden = false
            btnPre.isEnabled = true
            btnNext.isEnabled = true
            curTab = 3
            break
        case 4:
            imgNameString = "button_grammar_02.png"
            grammarView?.isHidden = false
            grammarView?.loadData(index: DataManager.shared.selectedLession)
            btnNext.isEnabled = false
            btnPre.isEnabled = true
            curTab = 4
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
        paging.currentPage = curTab - 1
        sender.setImage(UIImage(named: imgNameString), for: .normal)
    }
    
    @IBAction func btnPagingClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            btnNext.isEnabled = true
            if curTab > 1
            {
                curTab -= 1
                selectTabWithTag(tag: curTab)
            }
            break
        case 1:
            btnPre.isEnabled = true
            if curTab < 4
            {
                curTab += 1
                selectTabWithTag(tag: curTab)
            }
            break
        default:
            
            break
        }
    }
    
    func selectTabWithTag(tag: Int) {
        switch tag {
        case 1:
            btnClicked(btnBeforRead)
            break
        case 2:
            btnClicked(btnRead)
            break
        case 3:
            btnClicked(btnVocabulary)
            break
        case 4:
            btnClicked(btnGrammar)
            break
            
        default:
            break
        }
    }
    
    func hiddenAllSubView() {
        beforeReadView?.isHidden = true
        readView?.isHidden = true
        vocabularyView01?.isHidden = true
        vocabularyView02?.isHidden = true
        grammarView?.isHidden = true
    }
    
    @IBAction func btnScoreClicked(_ sender: AnyObject) {
        
        if DataManager.shared.selectedLession == -1{
            return
        }
        
        let alert = UIAlertController(title: "Chapter \(DataManager.shared.selectedLession + 1)", message: "Do you want to submit this Chapter?", preferredStyle: .actionSheet)
        
        alert.modalPresentationStyle = .popover
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            DataManager.shared.isScore = true
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
        }))
        
        alert.popoverPresentationController?.sourceView = self.btnScore
        alert.popoverPresentationController?.sourceRect = self.btnScore.bounds
        
        self.present(alert, animated: true, completion: nil)
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
        
        DataManager.shared.isScore = false
        
        DataManager.shared.curReadAnswer = 0
        
        DataManager.shared.loadReadVoca4Grammar()
        
        viewPaging.isHidden = false

        btnClicked(btnBeforRead)
        
        Utils.pauseBackgoundMusic()
        
        cell.cellSelect()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? LessionCell
        cell?.cellDeSelect()
    }
    
}
