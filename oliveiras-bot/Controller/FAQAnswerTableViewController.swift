//
//  FAQAnswerTableViewController.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 21/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class FAQAnswerTableViewController: UITableViewController {
    
    let cellId: String = "FAQAnswerTableViewCell"
    var questionTitle: String!
    
    let headerHight: CGFloat = 55

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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView()
        let labelHeight: CGFloat = 18
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: headerHight - labelHeight - 12,
                                          width: self.view.frame.size.width,
                                          height: labelHeight))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        
        switch section {
        case 0:
            label.text = self.questionTitle
        default:
            label.text = "Needs to be specified"
        }
        
        titleView.addSubview(label)

        return titleView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FAQAnswerTableViewCell
        cell.answer.text = "Os coronavírus são uma grande família viral, conhecidos desde meados de 1960, que causam infecções respiratórias em seres humanos e em animais. Geralmente, infecções por coronavírus causam doenças respiratórias leves a moderadas, semelhantes a um resfriado comum. Porém, alguns coronavírus podem causar doenças graves com impacto em termos de saúde pública, como já verificado com a Síndrome Respiratória Aguda Grave (SARS), identificada em 2002, e a Síndrome Respiratória do Oriente Médio (MERS)"
        
        cell.reference.text = "PAHO"
        return cell
    }
}
