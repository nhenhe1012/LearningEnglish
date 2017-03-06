//
//  ViewController.swift
//  LearningEnglish
//
//  Created by Tien on 3/3/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var mainController: MainLearningViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainController = MainLearningViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(mainController!, animated: false, completion: nil)
    }
}

