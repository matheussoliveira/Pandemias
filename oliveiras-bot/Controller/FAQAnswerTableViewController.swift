//
//  FAQAnswerTableViewController.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 21/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class FAQAnswerTableViewController: UITableViewController {
    
    let questionCell: String = "FAQQuestionTableViewCell"
    let answerCell: String = "FAQAnswerTableViewCell"
    var questionTitle: String!
    var questionAnwser: String!
    
    let headerHight: CGFloat = 55

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: questionCell, bundle: nil), forCellReuseIdentifier: questionCell)
        self.tableView.register(UINib.init(nibName: answerCell, bundle: nil), forCellReuseIdentifier: answerCell)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: questionCell, for: indexPath) as! FAQQuestionTableViewCell
            cell.question.text = self.questionTitle
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath) as! FAQAnswerTableViewCell
            cell.answer.text = self.questionAnwser
            return cell
        }
    }
}
