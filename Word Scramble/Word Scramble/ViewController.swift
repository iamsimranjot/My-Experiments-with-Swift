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
        
        if isPossible(word: lowerAnswer) && isOriginal(word: lowerAnswer) && isReal(word: lowerAnswer) {
            
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func isPossible(word: String) -> Bool {
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return true
    }
    
    func isReal(word: String) -> Bool {
        return true
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

