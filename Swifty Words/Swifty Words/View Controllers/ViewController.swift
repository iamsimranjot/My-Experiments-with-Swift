//
//  ViewController.swift
//  Swifty Words
//
//  Created by SimranJot Singh on 08/03/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    
    // MARK: IBOutlets

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    // MARK: Properties
    
    var solutions = [String]()
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var level = 1
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLetterButtons()
        loadLevel()
    }
    
    
    // MARK: Helper Functions
    
    func prepareLetterButtons() {
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
    }
    
    func loadLevel() {
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let resourcePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            
            if let levelContents = try? String(contentsOfFile: resourcePath) {
                
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                for (index, line) in lines.enumerated() {
                    
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1)." + "\(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    @objc func letterTapped(btn: UIButton) {
        
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    
    // MARK: IBActions

    @IBAction func submitTapped(_ sender: UIButton) {
        
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
            splitAnswers[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitAnswers.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
}

