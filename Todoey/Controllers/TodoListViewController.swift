//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var newItem = Item()
        newItem.title = "Eat"
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Pray"
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Finish Tasks"
        itemArray.append(newItem3)
//        if let items = defaults.array(forKey: "TodoListArray") as? [String]
//        {
//            itemArray = items
//        }
    }
    
    //MARK: - Table View DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell"  , for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        if item.done
        {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
       
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            var newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField() { (alertTextField) in
            alertTextField.placeholder = "Item's Name"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true , completion: nil)
    }
    
}
