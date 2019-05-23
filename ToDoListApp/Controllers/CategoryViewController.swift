//
//  CategoryViewController.swift
//  ToDoListApp
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {

    
    var context : NSManagedObjectContext?
    var categoryArray : [Category] = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            context = delegate.persistentContainer.viewContext
        }
        
        loadData()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    
    //MARK:- Add button for category was pressed
    @IBAction func addButtonCategoryPressed(_ sender: UIBarButtonItem) {
        
        var UItextField : UITextField?
        
        let alert = UIAlertController(title: "Add Category", message: "Insert New category", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Add Category", style: .default) { (action1) in
            
            let nameString = UItextField?.text
            let categoryToBeAdded = Category(context: self.context!)
            
            categoryToBeAdded.name = nameString
            
            self.saveData()
            self.loadData()
            
            self.tableView.reloadData()
            
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            
        }
        
        alert.addTextField { (categoryTextField) in
            UItextField = categoryTextField
            categoryTextField.placeholder = "Name of category"
        }
        
        alert.addAction(action1)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- SaveData method for saving the context
    func saveData(){
        
        do{
            try context?.save()
        }
        catch{
            print("Error in saveDataFunction \(error)")
        }
    }
    
    //MARK:- loadData method for loading data from the context
    func loadData(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
       
        do{
            categoryArray = try context!.fetch(request)
        }
        catch{
            print("Error in loadDatamethod \(error)")
        }
        
    }
    
    
    
    //MARK:- TableView did select for row at indexPath method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToListViewController", sender: self)
        
        
    }
    
    //MARK:- Prepare for segue upon table view cell selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        destinationVC.selectedCategory = categoryArray[tableView.indexPathForSelectedRow!.row]
        
    }
}
