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
    
    var selectedLession: Int = -1
    
    var isPlayingSound: Bool = false
    
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
    
    func loadLessionData()
    {
        copyToDocument()
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("NheNhe.sqlite")
        
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
