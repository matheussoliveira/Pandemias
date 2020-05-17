//
//  StatisticsLocationCell.swift
//  oliveiras-bot
//
//  Created by Julia Conti Mestre on 15/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class StatisticsLocationCell: UITableViewCell {
    
    // LOCATION SECTION
    @IBOutlet weak var countryIcon: UIImageView!
    @IBOutlet weak var disclosureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
