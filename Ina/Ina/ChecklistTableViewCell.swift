//
//  ChecklistTableViewCell.swift
//  Ina
//
//  Created by Zachary Skemp on 6/29/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
