//
//  FilterTableViewController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 19/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup navigation bar
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(rightButtonTapped))

    }
    
    @objc func rightButtonTapped(){
        print("tapped")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
