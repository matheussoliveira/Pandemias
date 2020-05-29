//
//  ReferenceTableViewCell.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 21/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ReferenceTableViewCell: UITableViewCell {

    @IBOutlet weak var information: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
