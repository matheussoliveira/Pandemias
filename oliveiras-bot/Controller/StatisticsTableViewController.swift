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
    
    // Cell identifier
    let cellId = "VisaoGeralTableViewCell"
    
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
    
    var chartType: ChartType = .confirmed
    var chartColor = UIColor()
    
    let headerHight: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Estatísticas"
        
        //Set segment control properties
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        //Set Charts Properties
        setChartProperties()
    }
    
    func setChartProperties() {
        let index = segmented.selectedSegmentIndex
        
        switch index {
        case 0:
            chartType = .confirmed
            chartColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
            dailyGlobalCases(caseType: "confirmed")
        case 1:
            chartType = .recovered
            chartColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
        case 2:
            chartType = .deaths
            chartColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
            dailyGlobalCases(caseType: "deaths")
        default:
            chartType = .confirmed
        }
    }
    
    func plotGraphic(chartColor: UIColor, chartValues: [(x: String, y: Int)]) {
        //Array that will display the graphic
        var chartEntry = [ChartDataEntry]()
        var days: [String] = []
        
        for i in 0..<chartValues.count {
            //Set x and y status in a data chart entry
            let xValue = chartValues[i].x
            let yValue = chartValues[i].y
            let value = ChartDataEntry(x: Double(i), y: Double(yValue))
            
            days.append(xValue)
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
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.axisMinimum = 0
        chartView.leftAxis.axisMinimum = 0
        
    }
    
    @IBAction func changeChartType(_ sender: UISegmentedControl) {
        setChartProperties()
    }
    

}

// MARK: API Calls
extension StatisticsTableViewController {
    func dailyGlobalCases(caseType: String) {
        var result: [(x: String, y: Int)] = []
        
        guard let url = URL(string: "https://covid19.mathdro.id/api/daily")
            else {
                print("Error while getting api url")
                return
            }
        
        let session = URLSession.shared
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        
                        for data in json {
                            let caseType = data[caseType] as? [String:Any]

                            let caseNumber = caseType?["total"] as? Int ?? 0
                            let day = data["reportDate"] as? String ?? ""
                            let formatedDay = Date.getFormattedDate(dateToFormat: day, originalFormat: "yyyy-MM-dd", newFormat: "dd/MM")
                            
                            let value = (x: formatedDay, y: caseNumber)
                            
                            result.append(value)
                        }
                        
                        DispatchQueue.main.async {
                            self.plotGraphic(chartColor: self.chartColor, chartValues: result)
                            self.tableView.reloadData()
                        }
                    }
                } catch { print(error) }
            }
        }).resume()
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
        
        if (indexPath.row == 0 && indexPath.section == 2) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VisaoGeralTableViewCell
            return cell
            
        } else {
        
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
}

extension Date {
    static func getFormattedDate(dateToFormat: String, originalFormat: String, newFormat:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = originalFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = newFormat

        let date: Date? = dateFormatterGet.date(from: dateToFormat)
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
}
