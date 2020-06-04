//
//  FAQViewController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 07/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit
import Foundation
import FirebaseStorage

class FAQController: UITableViewController {
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    let cellId = "FAQTableViewCell"
    var faqData: FAQJSon!
    var selectedRow: Int!
    var indicator = UIActivityIndicatorView()
    
    struct FAQJSon: Decodable {
        var font: String
        var faq: [FAQ]
    }
    
    struct FAQ: Decodable {
        var question: String
        var answer: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .clear
        
        self.infoButton.isEnabled = false
        
        loadJSON()
    }
    
    //MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows: Int!
        
        if (faqData != nil) {
            numberOfRows = faqData.faq.count
        } else {
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FAQTableViewCell
        
        if (faqData != nil) {
            cell.information.text = faqData.faq[indexPath.row].question
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "goToAnswer", sender: nil)
    }
    
    // MARK: - Navigaton
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToAnswer") {
            if let newVC = segue.destination as? FAQAnswerTableViewController {
                newVC.questionTitle = self.faqData.faq[self.selectedRow].question
                newVC.questionAnwser = self.faqData.faq[self.selectedRow].answer
            }
        } else if (segue.identifier == "goToReference") {
            if let newVC = segue.destination as? ReferenceTableViewController {
                newVC.referenceInformationString = self.faqData.font
            }
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }
    
    // MARK: - JSON
    
    func loadJSON() {
        
        let storage = Storage.storage()
        let islandRef = storage.reference().child("faq.json")
        
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
            print(error)
          } else {
            do {
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode([FAQJSon].self, from: data!)
                self.faqData = jsonData[0]
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.infoButton.isEnabled = true
                self.tableView.reloadData()
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
          }
        }
    }
    
    // MARK: - Activity indicator
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .medium
        indicator.color = UIColor(rgb: 0xFE375F)
        indicator.center = CGPoint(x: self.tableView.center.x, y: self.tableView.center.y - 120)
        self.tableView.addSubview(indicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
}

// Be able to use HEX colors in UIColor

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

