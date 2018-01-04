//
//  ViewController.swift
//  Storm Viewer
//
//  Created by SimranJot Singh on 04/01/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePicturesWithFilePaths()
    }
    
    func populatePicturesWithFilePaths() {
        
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath else { return }
        
        let items: [String]
        
        do {
            items = try fileManager.contentsOfDirectory(atPath: path)
        } catch let error as NSError {
            print(error)
            return
        }
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

}

