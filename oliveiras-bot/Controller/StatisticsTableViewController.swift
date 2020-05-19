//
//  StatisticsController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 07/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit
import Charts

class StatisticsTableViewController: UITableViewController {
    
    // LOCATION SECTION
    @IBOutlet weak var countryIcon: UIImageView!
    @IBOutlet weak var disclosureLabel: UILabel!
    
    // GRAPHIC SECTION
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var chartView: LineChartView!
    
    enum ChartType {
        case confirmed
        case recovered
        case deaths
    }
    
    var chartNumbers: [Double] = [200,500,100,800,300,120,600]
    var chartType: ChartType = .confirmed
    
    let headerHight: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Estatísticas"
        
        //Set segment control properties
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        plotGraphic(chartColor: #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1))
    }
    
    func plotGraphic(chartColor: UIColor) {
        //Array that will display the graphic
        var chartEntry = [ChartDataEntry]()
        
        for i in 0..<chartNumbers.count {
            //Set x and y status in a data chart entry
            let value = ChartDataEntry(x: Double(i), y: chartNumbers[i])
            
            chartEntry.append(value)
        }
        
        //Convert the entry to a data set
        let line = LineChartDataSet(chartEntry)
        line.colors = [chartColor]
        line.drawCirclesEnabled = false
        line.fill = Fill.fillWithCGColor(chartColor.cgColor)
        line.fillAlpha = 0.6
        line.drawFilledEnabled = true
        line.lineWidth = 2.0
        
        //Data to add to the chart
        let data = LineChartData()
        data.addDataSet(line)
        data.setDrawValues(false)
    
        chartView.data = data
        chartView.legend.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = .white
        chartView.leftAxis.labelTextColor = .white
        chartView.rightAxis.enabled = false
    }
    
    
    @IBAction func changeChartType(_ sender: UISegmentedControl) {
        var chartColor = UIColor()
//        var chartNumbers: [Double] = []
        //set api values
        
        switch sender.selectedSegmentIndex {
        //CONFIRMED
        case 0:
            chartType = .confirmed
            chartColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
            
        //RECOVERED
        case 1:
            chartType = .recovered
            chartColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
        //DEATHS
        case 2:
            chartType = .deaths
            chartColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
        default:
            chartType = .confirmed
            chartColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
        }
        
        plotGraphic(chartColor: chartColor)
        print(sender.selectedSegmentIndex)
    }
    

}

// MARK: TableView Controller Functions
extension StatisticsTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView()
        let labelHeight: CGFloat = 18
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: headerHight - labelHeight - 12,
                                          width: self.view.frame.size.width,
                                          height: labelHeight))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        
        switch section {
        case 0:
            label.text = "Localização"
        case 1:
            label.text = "Gráficos de estatísticas"
        case 2:
            label.text = "Visão geral"
        default:
            label.text = "Needs to be specified"
        }
        
        titleView.addSubview(label)

        return titleView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch indexPath.section {
        case 0:
            let chevron = UIImage(named: "chevron-icon")
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView = UIImageView(image: chevron!)
        default:
            break
        }
        
        return cell
    }
}
