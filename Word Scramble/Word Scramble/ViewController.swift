//
//  ViewController.swift
//  Word Scramble
//
//  Created by SimranJot Singh on 21/01/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit
import GameplayKit

var allWords = [String]()
var usedWords = [String]()

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        loadWordsFromResource()
        startGame()
    }
    
    func startGame() {
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as? [String] ?? [String]()
        title = allWords[0]
        
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func loadWordsFromResource(){
        
        if let resourcePath = Bundle.main.path(forResource: "start", ofType: "txt") {
            
            let words: String
            
            do {
                words = try String(contentsOfFile: resourcePath)
                allWords = words.components(separatedBy: "\n")
                
            } catch let error as NSError {
                print(error)
                allWords = ["silkworm"]
            }
        }
    }
    
    @objc func promptForAnswer() {
        
        let alertController = UIAlertController.init(title: "Enter Answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction.init(title: "Submit", style: .default) { [unowned self, alertController] _ in
            
            let answer = alertController.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    func submit(answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        
        var tempWord = title!.lowercased()
        
        for letter in word {
            
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

