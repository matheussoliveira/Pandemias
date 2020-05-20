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
    
    var chartNumbers: [Double] = [200,500,100,800,300,120,600]
    
    enum ChartColor {
        case confirmed
        case recovered
        case deaths
    }
    
    let headerHight: CGFloat = 55
    
    // VISAO GERAL SECTION
    let cellId = "VisaoGeralTableViewCell"
    
    // coronaStatistics[0] - Confirmed
    // coronaStatistics[1] - Recovered
    // coronaStatistics[2] - Active
    // coronaStatistics[3] - Deaths
    var coronaStatistics: [Int]!
    
    // SELECTED LOCATION
    var selectedLocation: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Estatísticas"
        
        //Set segment control properties
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        plotGraphic()
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        // TODO: Get selected location based
        // on user selection
        self.selectedLocation = "Mundo"
        
        getCasesNumber(location: selectedLocation)
    }
    
    func plotGraphic() {
        //Array that will display the graphic
        var chartEntry = [ChartDataEntry]()
        
        for i in 0..<chartNumbers.count {
            //Set x and y status in a data chart entry
            let value = ChartDataEntry(x: Double(i), y: chartNumbers[i])
            
            chartEntry.append(value)
        }
        
        //Convert the entry to a data set
        let line = LineChartDataSet(chartEntry)
        line.colors = [#colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)]
        line.drawCirclesEnabled = false
        line.fill = Fill.fillWithCGColor(#colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1))
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
    
    // MARK: - Table View Data Source
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
            
            if (self.coronaStatistics != nil) {
                
                cell.confirmedNumber.text = formatNumber(number: coronaStatistics[0])
                cell.recoveredNumber.text = formatNumber(number: coronaStatistics[1])
                cell.activeNumber.text = formatNumber(number: coronaStatistics[2])
                cell.deathsNumber.text = formatNumber(number: coronaStatistics[3])
            }
            
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
    
    // MARK: - API Functions
    func getCasesNumber(location: String) {
        // Builds an array with
        // confirmed, recoreved, active
        // and deaths cases, using corona api
        
        var apiURL: String!
        
        if (location == "Mundo") {
            apiURL = "https://covid19.mathdro.id/api/"
        } else {
            apiURL = "https://covid19.mathdro.id/api/countries/\(location)"
        }
        
        guard let url = URL(string: apiURL)
            
            else {
                print("Error while getting api url")
                return
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
                            self.coronaStatistics = [confirmedNumber, recoveredNumber, activeNumber, deathsNumber]
                         }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch { print(error) }
            }
        }.resume()
    }
    
    // MARK: - Auxiliary Functions
    
    func formatNumber(number: Int) -> String {
        // Formats large numbers to
        // a String with a comma
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:number)) ?? "-"
        
        return formattedNumber
    }

}
