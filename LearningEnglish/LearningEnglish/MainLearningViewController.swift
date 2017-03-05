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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.register(UINib(nibName: "LessionCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
}

extension MainLearningViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = String(indexPath.row)
        
        return cell!
    }
}
