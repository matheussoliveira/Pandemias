//
//  VisaoGeralTableViewCell.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 15/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class VisaoGeralTableViewCell: UITableViewCell {
    
    // Labels
    @IBOutlet weak var confirmedNumber: UILabel!
    @IBOutlet weak var recoveredNumber: UILabel!
    @IBOutlet weak var activeNumber: UILabel!
    @IBOutlet weak var deathsNumber: UILabel!
    
    // Views
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var recoveredView: UIView!
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var deathsView: UIView!
    
    // Activity Indicator
    
    @IBOutlet weak var confirmedIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recoveredIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activesIndicator: UIActivityIndicatorView!
    @IBOutlet weak var deathsIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
