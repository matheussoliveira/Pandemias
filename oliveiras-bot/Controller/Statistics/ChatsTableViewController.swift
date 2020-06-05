//
//  ChatsTableViewController.swift
//  oliveiras-bot
//
//  Created by Julia Conti Mestre on 02/06/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatSubtitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
        } else {
            perform(#selector(showOnBoarding), with: nil, afterDelay: 0.01)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    @objc func showOnBoarding(){
        let onBoardingController = storyboard?.instantiateViewController(withIdentifier: "OnBoarding") as! IntroViewController
        onBoardingController.modalPresentationStyle = .fullScreen
        present(onBoardingController, animated: false) {
            //
        }
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
            cell.accessoryType = .disclosureIndicator
            chatName.text = "June"
            chatSubtitle.text = "Coronavírus (Covid - 19)"
        }
        

        return cell
    }

    
}
