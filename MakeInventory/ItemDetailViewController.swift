//
//  ItemDetailViewController.swift
//  MakeInventory
//
//  Created by Phyllis Wong on 2/6/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    // variables
    var inventory: Inventory?

    // actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        print("some stuff happens")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
