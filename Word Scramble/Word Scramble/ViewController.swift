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
}

