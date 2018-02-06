//
//  ItemDetailViewController.swift
//  MakeInventory
//
//  Created by Phyllis Wong on 2/6/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var productName: String?
    var quantity: Int64?
    var date: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemTextField.text = "some shit"
        self.quantityTextField.text = "some other shit"
        self.dateLabel.text = "some date"
        
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        print("some stuff happens")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
