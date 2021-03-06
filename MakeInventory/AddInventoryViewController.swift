//
//  AddInventoryViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class AddInventoryViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var inventoryNameField: UITextField!
    @IBOutlet weak var inventoryQuantityField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let name = inventoryNameField.text, let quantity = Int64(inventoryQuantityField.text!) else {return}
        
        // set the date property
        // update the tableView
        let date = Date()
        
        
        let inv = Inventory(
            context: coreDataStack.privateContext
        )
        
        // Update the data store with the values entered by the user
        inv.name = name
        inv.quantity = quantity
        inv.date = date
        
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
