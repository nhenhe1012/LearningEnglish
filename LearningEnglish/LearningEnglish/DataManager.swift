//
//  DataManager.swift
//  Look and Guess a Word!
//
//  Created by TienNT12 on 2/20/17.
//  Copyright © 2017 TienNT12. All rights reserved.
//

import Foundation

class DataManager{
    
    static let shared = DataManager()
    
    func copyToDocument() {
        let fileManger = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent("com.tiennt12.picandword.database.sqlite")
        let sourcePath = Bundle.main.path(forResource: "com.tiennt12.picandword.database", ofType: "sqlite")
        if fileManger.fileExists(atPath: destinationPath) {
            return
        }
        
        do {
            try fileManger.copyItem(atPath: sourcePath!, toPath: destinationPath)
        } catch{
            print("error")
        }
    }
    
    func loadData()
    {
        
        copyToDocument()
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("com.tiennt12.picandword.database.sqlite")
        
        var db: OpaquePointer? = nil
        var statement: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(db, "select * from Level", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing select: \(errmsg)")
        }
        
//        while sqlite3_step(statement) == SQLITE_ROW {
//            var data = WordStruct()
//            data.id = Int(sqlite3_column_int64(statement, 0))
//            
//            if let img = sqlite3_column_blob(statement, 2)
//            {
//                let len = sqlite3_column_bytes(statement, 2)
//                data.image1 = NSData(bytes: img, length: Int(len)) as Data
//            }
//            if let img = sqlite3_column_blob(statement, 3)
//            {
//                let len = sqlite3_column_bytes(statement, 3)
//                data.image2 = NSData(bytes: img, length: Int(len)) as Data
//            }
//            if let img = sqlite3_column_blob(statement, 4)
//            {
//                let len = sqlite3_column_bytes(statement, 4)
//                data.image3 = NSData(bytes: img, length: Int(len)) as Data
//            }
//            if let img = sqlite3_column_blob(statement, 5)
//            {
//                let len = sqlite3_column_bytes(statement, 5)
//                data.image4 = NSData(bytes: img, length: Int(len)) as Data
//            }
//            if let word = sqlite3_column_text(statement, 6) {
//                data.word = String(cString: word)
//            }
//            data.isWon = Int(sqlite3_column_int64(statement, 7))
//            
//            listData.append(data)
//        }
        
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
