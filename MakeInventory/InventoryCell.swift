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
            var displayDate : String {
                let formatter = DateFormatter()
                formatter.timeStyle = .none
                formatter.dateStyle = .short
                return formatter.string(from: Date())
            }
            
            titleInvLabel.text = inventory?.name
            quantityInvLabel.text = inventory?.quantity.description
            dateInvLabel.text = displayDate
        }
    }
    
    func convertDateToDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: Date())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
