//
//  SSTableViewController.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 15/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import Foundation
import UIKit

class SSTableViewController: UITableViewController {
    
    let cellId = "VisaoGeralTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VisaoGeralTableViewCell
        let casesNumber = self.getCasesNumber()
        return cell
    }
    
    func getCasesNumber() -> [Int] {
        
        var casesNumberArray: [Int] = [0]
        
        guard let url = URL(string: "https://covid19.mathdro.id/api/")
            
            else {
                print("Error while getting api url")
                return [0]
            }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let deaths = json["deaths"] as? [String:Any],
                           let recovered = json["recovered"] as? [String:Any],
                           let confirmed = json["confirmed"] as? [String:Any] {
                            
                            let deathsNumber = deaths["value"] as? Int ?? 0
                            let confirmedNumber = confirmed["value"] as? Int ?? 0
                            let recoveredNumber = recovered["value"] as? Int ?? 0
                            let activeNumber = confirmedNumber - deathsNumber - recoveredNumber
                            casesNumberArray = [deathsNumber, confirmedNumber, recoveredNumber, activeNumber]
                         }
                    }
                    
                } catch { print(error) }
            }
        }.resume()
        
        return casesNumberArray
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
