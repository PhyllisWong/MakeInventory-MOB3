//
//  ItemDetailViewController.swift
//  MakeInventory
//
//  Created by Phyllis Wong on 2/6/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    // outlets
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    // variables
    var inventory: Inventory?

    // actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Item Detail"
        
        let productName = inventory?.name
        let quantity = inventory?.quantity.description
        // let date = inventory?.date?.description
        
        var displayDate : String {
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            return formatter.string(from: Date())
        }
        
        
        self.itemTextField.text = productName
        self.quantityTextField.text = quantity
        self.dateLabel.text = displayDate
        
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let name = itemTextField.text, let quantity = Int64(quantityTextField.text!) else {return}
        
        let inv = Inventory(
            context: coreDataStack.privateContext
        )
        
        inv.name = name
        inv.quantity = quantity
        
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        
        print("some stuff happens")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
