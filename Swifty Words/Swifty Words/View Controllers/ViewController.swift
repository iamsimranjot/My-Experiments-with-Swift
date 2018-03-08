//
//  ViewController.swift
//  Swifty Words
//
//  Created by SimranJot Singh on 08/03/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: IBOutlets

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: IBActions

    @IBAction func submitTapped(_ sender: UIButton) {
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
    }
}

