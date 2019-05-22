//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Admin on 21/05/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    
    var itemArray : [Item] = [Item]()
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("toDoListItems.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(dataFilePath)
        
        
        let itemToAdd = Item()
        itemToAdd.title = "First"
        print(itemToAdd.title)
        itemArray.append(itemToAdd)
        
        let itemToAdd1 = Item()
        itemToAdd1.title = "Second"
        itemArray.append(itemToAdd1)
        
        let itemToAdd2 = Item()
        itemToAdd2.title = "Third"
        itemArray.append(itemToAdd2)
        
        var itemToAdd3 = Item()
        itemToAdd3.title = "Fourth"
        itemArray.append(itemToAdd3)
        
        
        
      
        
        
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
       
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - When a table view cell gets selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
       
        
        let encoder  = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }
        catch{
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    // MARK:- When table view cell gets deselected
    
    
    // MARK:- Functions when add button is pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textStringToBeAppended = UITextField()
        
        var alert = UIAlertController(title: "Add New Items", message: "Enter new items to be added", preferredStyle: .alert)
        
        var action = UIAlertAction(title: "Add items", style: .default){ (a) in
            print("Successs button is working!")
            
            var itemToBeAdded = Item()
            
            itemToBeAdded.title = textStringToBeAppended.text!
            self.itemArray.append(itemToBeAdded)
            
            let encoder = PropertyListEncoder()
            
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }
            catch{
                print(error)
            }
            
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
    
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print(error)
        }
    }
    
}

