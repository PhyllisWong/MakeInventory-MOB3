//
//  InventoryCell.swift
//  MakeInventory
//
//  Created by Phyllis Wong on 2/6/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {

    @IBOutlet weak var titleInvLabel: UILabel!
    @IBOutlet weak var quantityInvLabel: UILabel!
    @IBOutlet weak var dateInvLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var inventory: Inventory? {
        
        didSet {
            titleInvLabel.text = inventory?.name
            quantityInvLabel.text = inventory?.quantity.description
            dateInvLabel.text = inventory?.date?.description
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
