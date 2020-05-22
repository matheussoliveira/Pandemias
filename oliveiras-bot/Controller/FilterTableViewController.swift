//
//  FilterTableViewController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 19/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

protocol selectedCountryProtocol: NSObjectProtocol {
    func setCountry(country: Country)
}

class FilterTableViewController: UITableViewController, UISearchResultsUpdating{

    struct Section {
        let letter : String
        let countries : [Country]
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)

    
    let countries = Country.alphaDictionary()
    var sectionArray = [Section]()
    var sectionTitles = [String]()
    var filteredSections = [Section]()
    var filteredCountries = [Country]()
    var lastSelection: NSIndexPath!
    
    var selectedCountry = Country(name: "Mundo", image: UIImage(named: "world")!)
    weak var delegate:selectedCountryProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
        //setup navigation bar
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        //setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar região"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        
        setupArray()

    }
    
    func setupArray(){
        
        let world = Country(name: "Mundo", image: UIImage(named: "world")!)
        let firstSection = Section(letter: " ", countries: [world])
        
        //setup sections in alphabetical order
        let sortedCountries = countries.sorted(by: { $0.0 < $1.0 })
        for (key, value) in sortedCountries {
            sectionArray.append(Section(letter: key, countries: value))
        }
        
        sectionArray.insert(firstSection, at: 0)
        sectionTitles = [String](countries.keys)
    }
    
    
    @objc func rightButtonTapped(){
        delegate?.setCountry(country: self.selectedCountry)
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
        if isFiltering {
            return 1
        } else{
            return sectionArray.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        } else {
            return sectionArray[section].countries.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return nil
        } else {
            return sectionArray[section].letter
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isFiltering {
            return 0
        }

        return tableView.sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell
        
        if isFiltering {
            cell.label.text = filteredCountries[indexPath.row].name
            cell.flag.image = filteredCountries[indexPath.row].image
        } else {
            cell.label.text = sectionArray[indexPath.section].countries[indexPath.row].name
            cell.flag.image = sectionArray[indexPath.section].countries[indexPath.row].image
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.lastSelection != nil {
            self.tableView.cellForRow(at: self.lastSelection as IndexPath)?.accessoryType = .none
        }
        
        if isFiltering{
            selectedCountry = filteredCountries[indexPath.row]
        } else{
            selectedCountry = sectionArray[indexPath.section].countries[indexPath.row]
        }
        
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.lastSelection = indexPath as NSIndexPath
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.sorted()
    }

    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      filterContentForSearchText(searchBar.text!)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCountries = []
        filteredSections = sectionArray.filter({ (section) -> Bool in
            for item in section.countries{
                if item.name.lowercased() == searchText.lowercased(){
                    filteredCountries.append(item)
                    return true
                }
            }
             return false
        })
        
        tableView.reloadData()
    }
    

}

