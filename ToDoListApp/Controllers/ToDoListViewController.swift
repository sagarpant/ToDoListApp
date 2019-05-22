//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Admin on 21/05/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {

    
    
    var itemArray : [Item] = [Item]()
    //let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("toDoListItems.plist")
    
    
    
    var context : NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            context = delegate.persistentContainer.viewContext
        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       // print(dataFilePath)
        //loadItems()
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        loadData()
    }

    
    //MARK: - TABLEVIEW DATASOURCE METHODS (Providing cell for a row in the table view to be displayed)
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
    
    //MARK: - Number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - When a table view cell gets selected (Did select row at method)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
       
        saveData()
//        let encoder  = PropertyListEncoder()
//        do{
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//
//        }
//        catch{
//            print(error)
//        }
        
//        tableView.reloadData()
        
    }
    
    // MARK:- When table view cell gets deselected
    
    
    // MARK:- Functions when add button is pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textStringToBeAppended = UITextField()
        
        var alert = UIAlertController(title: "Add New Items", message: "Enter new items to be added", preferredStyle: .alert)
        
        var action = UIAlertAction(title: "Add items", style: .default){ (a) in
            print("Successs button is working!")
            
            if let context = self.context {
                let itemToBeAdded = Item(context: context)
                itemToBeAdded.done = false
                itemToBeAdded.title = textStringToBeAppended.text!
                self.itemArray.append(itemToBeAdded)
            }
            
//            let encoder = PropertyListEncoder()
//
//            do{
//                let data = try? encoder.encode(self.itemArray)
//                try data!.write(to: self.dataFilePath!)
//            }
//            catch{
//                print(error)
//            }
            
//            let itemToBeAddedNew = Item(context: self.context)
            
            
            
            self.saveData()
            self.loadData()
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
    
    
//    func saveData(){
//        let encoder = PropertyListEncoder()
//        do{
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//        }
//        catch{
//            print(error)
//        }
//    }
    
    
    //Mark:- Save Data using core data function save data
    
    func saveData(){
        do{
            
        try context?.save()
        }
        catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    
    
    
    
//
//    func loadItems(){
//
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch{
//                print(error)
//            }
//
//
//
//        }
//
//    }
//
    
    
    //MARK:- Fetch data from the database to the itemsarray using NSFETCHREQUEST (COREDATA)
    
    func loadData(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
            itemArray = try context!.fetch(request)
            print(itemArray)
        }
        catch{
            print("Error in fetching the request in loadData method \(error)")
        }
        
    }
    
    
}

