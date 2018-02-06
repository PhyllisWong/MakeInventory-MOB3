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
    @IBOutlet weak var dateTextLebel: UILabel!
    
    var inventories = [Inventory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = inventories[indexPath.row]
        let date = selectedItem.date
        let productName = selectedItem.name
        let quantity = selectedItem.quantity
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        
        detailVC.productName = productName
        detailVC.quantity = quantity
        detailVC.date = date
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}






