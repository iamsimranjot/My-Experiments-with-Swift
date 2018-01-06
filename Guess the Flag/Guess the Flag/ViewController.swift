//
//  ViewController.swift
//  Guess the Flag
//
//  Created by SimranJot Singh on 06/01/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    // MARK: Properties & Outlets

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    
    // MARK: LifeCycle Mathods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearanceFor(button: button1)
        setAppearanceFor(button: button2)
        setAppearanceFor(button: button3)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
    }
    
    func setCountriesButtons() {
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func setAppearanceFor(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as? [String] ?? [String]()
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
        
        setCountriesButtons()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
    }
}

