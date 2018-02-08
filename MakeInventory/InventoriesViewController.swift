//
//  ViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    let stack = CoreDataStack.instance
    
    @IBOutlet weak var tableView: UITableView!
    
    var inventories = [Inventory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Inventory"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        // set the row height for the tableView large enough to display all the data
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 50
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateInventories()
//        let fetch = NSFetchRequest<Inventory>(entityName: "Inventory")
//        do {
//            let result = try stack.viewContext.fetch(fetch)
//            self.inventories = result
//            self.tableView.reloadData()
//
//        }catch let error {
//            print(error)
//        }
    }
    
    func updateInventories() {
        let fetch = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let result = try stack.viewContext.fetch(fetch)
            self.inventories = result
            self.tableView.reloadData()
            
        }catch let error {
            print(error)
        }
    }
}


extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }
}

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        let item = indexPath.item
        cell.inventory = inventories[item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let selectedItem = inventories[indexPath.row]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
//
//        detailVC.inventory = selectedItem
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
        print("Did select row at")
    }
    
    // Delete an item from the inventory by swiping left

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            print("Delete Action Tapped")
            let deleteItem = self.inventories[indexPath.row]
            // item to delete
            print(deleteItem)
            // delete data from the inventories array
            self.inventories.remove(at: indexPath.row)
            
            // delete the row from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.stack.viewContext.delete(deleteItem)
            try! self.stack.viewContext.save()
        }
        
        deleteAction.backgroundColor = .red
        
        
        let editAction = UITableViewRowAction(style: .destructive, title: "Edit") { (action, indexpath) in
            print("edit action tapped")
            let editItem = self.inventories[indexPath.row]
            print(editItem)
            
            
            
            // MARK: Alert View Controller
            func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
                
                //Creating UIAlertController and
                //Setting title and message for the alert dialog
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
                
                let okAction = UIAlertAction(title: "Save", style: .default) { (_) in
                    
                    //getting the input values from user
                    let newName = alertController.textFields?[0].text
                    var newQuantity: Int64?
                    if alertController.textFields?[1] != nil {
                        newQuantity = Int64((alertController.textFields?[1].text)!)
                    } else {
                        newQuantity = editItem.quantity
                    }
                    
                    
                            
                        
                  
                    
                        self.inventories[indexPath.row].quantity = newQuantity!
                    
                    
                    self.inventories[indexPath.row].name = newName
                    
                   
                    self.stack.saveTo(context: self.stack.privateContext)
                    self.updateInventories()
                }
                
                // alertController.addAction(okAction)
                
                //the cancel action doing nothing
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                
                //adding textfields to our dialog box
                alertController.addTextField { (textField) in
                    textField.placeholder = "Enter New Name"
                }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Change Quantity"
                }
                
                //adding the action to dialogbox
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                //finally presenting the dialog box
                self.present(alertController, animated: true, completion: nil)
            }
            
            let message = "enter new values"
            showAlertWith(title: "Edit item", message: message, style: .alert)
            
        }
        editAction.backgroundColor = .blue
        return [deleteAction, editAction]
    }
    
    func fetchInventoryandUpdate() {
        // grab the data store, and update with the new values
    }
    
//    func dismissAlert(sender: UIAlertAction) -> Void {
//
//        // edit the item in the data store
//
//        guard let name = itemTextField.text, let quantity = Int64(quantityTextField.text!) else {return}
//
//        let inv = Inventory(
//            context: stack.privateContext
//        )
//
//        inv.name = name
//        inv.quantity = quantity
//
//        stack.saveTo(context: stack.privateContext)
//
//        print("some stuff happens")
//
//        // print("you edited that crap")
//    }
    
}






