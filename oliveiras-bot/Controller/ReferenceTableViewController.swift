//
//  ReferenceTableViewController.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 21/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ReferenceTableViewController: UITableViewController {
    
    let headerHight: CGFloat = 45
    
    let cellId = "ReferenceTableViewCell"
    
    // TODO: Get real information about reference and update date
    var referenceInformationString: String = "Organização Pan-American da Saúde (OPAS), Organização Mundial da Saúde (OMS)"
    var referenceUpdateDateString: String = "Última atualização: 22/05/2020"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0
         
        switch section {
        case 0:
            label.text = "FONTE DE DADOS:"
        case 1:
            label.text = "ÚLTIMAS ATUALIZAÇÕES:"
        default:
            label.text = "Needs to be specified"
        }
         
        titleView.addSubview(label)

        return titleView
     }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        let labelHeight: CGFloat = headerHight

        let label = UILabel(frame: CGRect(x: 0,
                                          y: headerHight - labelHeight,
                                          width: self.view.frame.size.width - self.view.frame.size.width/4,
                                          height: labelHeight))
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0

        switch section {
        case 0:
            label.text = "As fontes acima tem permissão para atualizar os dados sobre dúvidas frequentes."
        case 1:
            label.text = "As fontes são atualizadas automaticamente."
        default:
            label.text = "Needs to be specified"
        }

        footerView.addSubview(label)

        return footerView
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0 && indexPath.section == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReferenceTableViewCell
            cell.information.text = self.referenceInformationString

            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReferenceTableViewCell
            cell.information.text = self.referenceUpdateDateString

            return cell
        }
    }
}
