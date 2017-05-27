//
//  GlossaryTableViewCell.swift
//  Ina
//
//  Created by Zachary Skemp on 5/25/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit

class GlossaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var diamondImage: UIImageView!
    
    @IBOutlet weak var termLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
