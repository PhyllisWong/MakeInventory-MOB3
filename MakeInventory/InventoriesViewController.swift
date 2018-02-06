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
        
        // set the row height for the tableView large enough to display all the data
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 50
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        // print("Inventory item: \(item)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = inventories[indexPath.row]
        let date = selectedItem.date
        let productName = selectedItem.name
        let quantity = selectedItem.quantity
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        print("Formatted date: \(dateFormatter.string(from: date!))")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        
        detailVC.productName = productName
        detailVC.quantity = quantity
        detailVC.date = date
        
        // programatic segue
        //self.navigationController?.pushViewController(detailVC, animated: true)
        
        // storyboard segue
        self.performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
    
    // Delete an item from the inventory by swiping left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // delete the row from the data source
            let deleteItem = inventories[indexPath.row]
            // item to delete
            print(deleteItem)
            
            // delete data from the inventories array
            self.inventories.remove(at: indexPath.row)
            
            // delete the row from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // delete request from the data store
            
        }
        
    }
    
}






