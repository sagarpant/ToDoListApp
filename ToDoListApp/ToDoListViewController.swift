//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Admin on 21/05/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    
    let itemArray = ["First", "Second", "Third"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - When a table view cell gets selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let cellAtWhichWeAreCurrently = tableView.cellForRow(at: indexPath)
        
        let choice = cellAtWhichWeAreCurrently?.accessoryType.rawValue
        
        if choice == 0{
            cellAtWhichWeAreCurrently?.accessoryType = .checkmark
        }
        else{
            cellAtWhichWeAreCurrently?.accessoryType = .none
        }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK:- When table view cell gets deselected
    
    

}

