//
//  PicturesTableViewController.swift
//  Storm Viewer
//
//  Created by SimranJot Singh on 04/01/18.
//  Copyright © 2018 Simranjot. All rights reserved.
//

import UIKit

class PicturesTableViewController: UITableViewController {
    
    
    // MARK: Properties
    
    var pictures = [String]()
    
    
    // MARK: Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        populatePicturesWithFilePaths()
    }
    
    
    // MARK: Helper Functions
    
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
    
    // MARK: Table View Delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailsVC.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

}

