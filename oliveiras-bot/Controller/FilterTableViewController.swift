//
//  FilterTableViewController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 19/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController{
    
    struct Section {
        let letter : String
        let countries : [Country]
    }
    
    let countries = Country.alphaDictionary()
    var sectionArray = [Section]()
    var sectionTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup navigation bar
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        //setup sections in alphabetical order
        let sortedCountries = countries.sorted(by: { $0.0 < $1.0 })
        for (key, value) in sortedCountries {
            sectionArray.append(Section(letter: key, countries: value))
        }
        
        sectionTitles = [String](countries.keys)

    }
    
    @objc func rightButtonTapped(){
        print("tapped")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        returnedView.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        label.text = sectionArray[section].letter
        returnedView.addSubview(label)

        return returnedView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].countries.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section].letter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell
        cell.label.text = sectionArray[indexPath.section].countries[indexPath.row].name
        cell.flag.image = sectionArray[indexPath.section].countries[indexPath.row].image
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.sorted()
    }

}
