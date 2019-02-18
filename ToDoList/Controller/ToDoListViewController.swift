//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Alexandr on 2/13/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    //MARK: - Private properties

    var itemArray = [Item]()
    var defaults = UserDefaults.standard

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Shop"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Go for a walk"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Clean up the room"
        itemArray.append(newItem3)

//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = items
//        }
    }


    //MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title

        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }


    //MARK: - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)

    }


    //MARK: - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add New Item button on UIALert

            let newItem = Item()
            newItem.title = textField.text!

            if textField.text != "" {
                self.itemArray.append(newItem)
            } else {
                return
            }

            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}
