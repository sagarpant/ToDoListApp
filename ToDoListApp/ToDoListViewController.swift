//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Admin on 21/05/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    
    var itemArray = ["First", "Second", "Third"]
    
    
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
    
    
    // MARK:- Functions when add button is pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textStringToBeAppended = UITextField()
        
        var alert = UIAlertController(title: "Add New Items", message: "Enter new items to be added", preferredStyle: .alert)
        
        var action = UIAlertAction(title: "Add items", style: .default){ (a) in
            print("Successs button is working!")
            
            self.itemArray.append(textStringToBeAppended.text!)
            self.tableView.reloadData()
            
        }
        var cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            
        }
        
        
        alert.addTextField { (textField) in
            textStringToBeAppended = textField
            textField.placeholder = "Name of Item"
            print("\(textField.text!)")
        }
        
        alert.addAction(action)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
        
    }
}

