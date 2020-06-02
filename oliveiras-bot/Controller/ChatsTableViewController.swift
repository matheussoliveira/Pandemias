//
//  ChatsTableViewController.swift
//  oliveiras-bot
//
//  Created by Julia Conti Mestre on 02/06/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatSubtitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatImage.layer.cornerRadius = chatImage.frame.width/2
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let chevron = UIImage(named: "chevron-icon")
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView = UIImageView(image: chevron!)
            chatImage.image = UIImage(named: "juneIcon.pdf")
            chatName.text = "June"
            chatSubtitle.text = "Coronavírus (Covid - 19)"
        }
        

        return cell
    }

    
}
