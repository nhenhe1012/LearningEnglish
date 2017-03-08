//
//  DataManager.swift
//  Look and Guess a Word!
//
//  Created by TienNT12 on 2/20/17.
//  Copyright © 2017 TienNT12. All rights reserved.
//

import Foundation

class DataManager{
    
    var arrLession = [Lession]()
    
    var arrReadQuestion = [QuestionType01]()
    
    var arrNguPhap = [QuestionType01]()
    
    var arrVoca4 = [QuestionType01]()
    
    var selectedLession: Int = -1
    
    var curReadAnswer: Int = 0
    
    var isPlayingSound: Bool = false
    
    var isScore: Bool = false
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("NheNhe.sqlite")
    
    static let shared = DataManager()
    
    func copyToDocument() {
        let fileManger = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent("NheNhe.sqlite")
        let sourcePath = Bundle.main.path(forResource: "NheNhe", ofType: "sqlite")
        if fileManger.fileExists(atPath: destinationPath) {
            return
        }
        
        do {
            try fileManger.copyItem(atPath: sourcePath!, toPath: destinationPath)
        } catch{
            print("error")
        }
    }
    
    func loadReadVoca4Grammar() {
    
        arrReadQuestion = [QuestionType01]()
        arrNguPhap = [QuestionType01]()
        arrVoca4 = [QuestionType01]()
        
        var db: OpaquePointer? = nil
        var statement: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(db, "select * from PhanDoc_NguPhan_TuVung4 where MaLession = \(DataManager.shared.selectedLession + 1)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            var question = QuestionType01()
            question.maCauHoi = Int(sqlite3_column_int64(statement, 0))
            question.maLession = Int(sqlite3_column_int64(statement, 1))
            question.dapAn = Int(sqlite3_column_int64(statement, 6))
            question.dangCauHoi = Int(sqlite3_column_int64(statement, 7))
            
            if let dapAnA = sqlite3_column_text(statement, 2) {
                question.dapAnA = String(cString: dapAnA)
            }
            if let dapAnB = sqlite3_column_text(statement, 3) {
                question.dapAnB = String(cString: dapAnB)
            }
            if let dapAnC = sqlite3_column_text(statement, 4) {
                question.dapAnC = String(cString: dapAnC)
            }
            if let dapAnD = sqlite3_column_text(statement, 5) {
                question.dapAnD = String(cString: dapAnD)
            }
            if let noiDung = sqlite3_column_text(statement, 8) {
                question.noiDung = String(cString: noiDung)
            }

            switch question.dangCauHoi {
            case 1:
                arrReadQuestion.append(question)
                break
            case 2:
                arrVoca4.append(question)
                break
            case 3:
                arrNguPhap.append(question)
                break
            default:
                
                break
            }
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        if sqlite3_close(db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        db = nil
        statement = nil
    }
    
    func loadLessionData()
    {
        copyToDocument()
        
        var db: OpaquePointer? = nil
        var statement: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(db, "select * from Lession", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            var lession = Lession()
            lession.maLession = Int(sqlite3_column_int64(statement, 0))
            lession.rating = Int(sqlite3_column_int64(statement, 2))
            if let name = sqlite3_column_text(statement, 1) {
                lession.tenBaiLam = String(cString: name)
            }
            if let name = sqlite3_column_text(statement, 3) {
                lession.bfTheRead = String(cString: name)
            }
            if let name = sqlite3_column_text(statement, 4) {
                lession.nVocabulary = String(cString: name)
            }
            if let name = sqlite3_column_text(statement, 5) {
                lession.iDiom = String(cString: name)
            }
            arrLession.append(lession)
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        if sqlite3_close(db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        db = nil
        statement = nil
        
    }
}
