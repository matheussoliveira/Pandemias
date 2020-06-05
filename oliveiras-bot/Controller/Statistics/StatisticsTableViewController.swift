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
    
    // Activity Indicator
    
    @IBOutlet weak var chartIndicator: UIActivityIndicatorView!
    
    enum ChartType {
        case confirmed
        case recovered
        case deaths
    }
    
    var chartType: ChartType = .confirmed
    var chartColor = UIColor()
    
    let headerHight: CGFloat = 55
    
    // VISAO GERAL SECTION
    let cellId = "VisaoGeralTableViewCell"
    
    // coronaStatistics[0] - Confirmed
    // coronaStatistics[1] - Recovered
    // coronaStatistics[2] - Active
    // coronaStatistics[3] - Deaths
    var coronaStatistics: [Int]!
    var lastUpdated: String = ""
    
    // SELECTED LOCATION
    var selectedLocation: String!
    
    var country = Country(name: "Mundo", image: UIImage(named: "world")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Estatísticas"
        
        //Set segment control properties
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        // Registering cell
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        chartView.isUserInteractionEnabled = true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateGeneralData()
        
        //Set Charts Properties
        setChartProperties()
        
        chartIndicator.startAnimating()
    }

    func setChartProperties() {
        var index = segmented.selectedSegmentIndex
        let countryNameUS = Countries().countryBRtoUS(countryNameBR: country.name)
        let countryNameSlug = Countries().countryToSlugAPI(countryNameUS: countryNameUS)
        
        //GLOBAL STATISTICS
        if country.name == "Mundo" {
            if segmented.numberOfSegments == 3 {
                segmented.removeSegment(at: 1, animated: true)
                segmented.selectedSegmentIndex = 0
                index = segmented.selectedSegmentIndex
            }
            switch index {
            case 0:
                chartType = .confirmed
                chartColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
                dailyGlobalCases(caseType: "confirmed")
            case 1:
                chartType = .deaths
                chartColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                dailyGlobalCases(caseType: "deaths")
            default:
                chartType = .confirmed
            }
        //COUNTRY STATISTICS
        } else {
            if segmented.numberOfSegments == 2 {
                segmented.insertSegment(withTitle: "Recuperados", at: 1, animated: true)
                segmented.selectedSegmentIndex = 0
                index = segmented.selectedSegmentIndex
            }
            switch index {
            case 0:
                chartType = .confirmed
                chartColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
                dailyCountryCases(country: countryNameSlug, caseType: "Confirmed")
            case 1:
                chartType = .recovered
                chartColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
                dailyCountryCases(country: countryNameSlug, caseType: "Recovered")
            case 2:
                chartType = .deaths
                chartColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                dailyCountryCases(country: countryNameSlug, caseType: "Deaths")
            default:
                chartType = .confirmed
            }

        }
        
    }
    
    func plotGraphic(chartColor: UIColor, chartValues: [(x: String, y: Int)], xAxisMin: Int) {
        let data = LineChartData()
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
        line.highlightColor = chartColor
        
        //Data to add to the chart
        data.addDataSet(line)
        data.setDrawValues(false)
        chartView.data = data
        chartView.zoom(scaleX: 0, scaleY: 0, x: 0, y: 0)
        
        chartView.legend.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = .white
        chartView.leftAxis.labelTextColor = .white
        chartView.rightAxis.enabled = false
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.axisMinimum = Double(xAxisMin)
        chartView.leftAxis.axisMinimum = 0
        chartView.pinchZoomEnabled = false
        chartView.drawBordersEnabled = true
        chartView.autoScaleMinMaxEnabled = true
        
        //Remove pinch and pan gesture
        if let gestures = chartView.gestureRecognizers {
            for gesture in gestures {
                if let recognizer = gesture as? UIPinchGestureRecognizer {
                    chartView.removeGestureRecognizer(recognizer)
                }
                if let recognizer = gesture as? UIPanGestureRecognizer {
                    chartView.removeGestureRecognizer(recognizer)
                }
            }
        }
    }
    
    func updateGeneralData() {
        let countryUS = Countries().countryBRtoUS(countryNameBR: country.name)
        let countrySlug = Countries().countryToSlugAPI(countryNameUS: countryUS)
        generalCases(location: countrySlug)
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
                            self.plotGraphic(chartColor: self.chartColor, chartValues: result, xAxisMin: 0)
                            self.tableView.reloadData()
                            self.chartIndicator.stopAnimating()
                            self.chartIndicator.hidesWhenStopped = true
                        }
                    }
                } catch { print(error) }
            }
        }).resume()
    }
    
    func dailyCountryCases(country: String, caseType: String) {
        var result: [(x: String, y: Int)] = []
        
        guard let url = URL(string: "https://api.covid19api.com/total/country/\(country)")
            else {
                print("Error while getting api url")
                return
            }
        
        let session = URLSession.shared
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        
                        var foundFirstConfirmed: Bool = false
                        var dayCounter: Int = 0
                        
                        for data in json {
                            let confirmedNumber = data["Confirmed"] as? Int ?? 0
                            let caseNumber = data[caseType] as? Int ?? 0
                            let day = data["Date"] as? String ?? ""
                            
                            let formatedDay = Date.getFormattedDate(dateToFormat: day, originalFormat: "yyyy-MM-dd'T'HH:mm:ssZ", newFormat: "dd/MM")
                            let value = (x: formatedDay, y: caseNumber)
                            
                            if !foundFirstConfirmed && confirmedNumber != 0 {
                                foundFirstConfirmed = true
                            } else if !foundFirstConfirmed {
                                dayCounter += 1
                            }
                            
                            result.append(value)
                        }
                        
                        DispatchQueue.main.async {
                            self.plotGraphic(chartColor: self.chartColor, chartValues: result, xAxisMin: dayCounter - 1)
                            self.tableView.reloadData()
                            self.chartIndicator.stopAnimating()
                            self.chartIndicator.hidesWhenStopped = true
                        }
                    }
                } catch { print(error) }
            }
        }).resume()
    }
    
    func generalCases(location: String) {
        guard let url = URL(string: "https://api.covid19api.com/summary")
            else {
                print("Error while getting api url")
                return
            }
        
        let session = URLSession.shared
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String:Any] {
                        
                        let global = json["Global"] as? [String:Any]
                        let countries = json["Countries"] as! [[String:Any]]
                        var confirmed: Int = 0
                        var recovered: Int = 0
                        var deaths: Int = 0
                        var active: Int = 0
                        
                        //Get last Update
                        for country in countries {
                            let slug = country["Slug"] as? String ?? ""
                            
                            if slug == "afghanistan" {
                                var dateString = country["Date"] as? String ?? ""
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                                dateFormatter.calendar = Calendar(identifier: .iso8601)
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                                if let dateFromString = dateFormatter.date(from: dateString) {
                                    dateFormatter.dateFormat = "dd/MM HH:mm"
                                    dateFormatter.timeZone = .current
                                    dateString = dateFormatter.string(from: dateFromString)
                                }

                                
                                self.lastUpdated = "\(dateString)"
                                break
                            }
                        }
                        
                        //Get numbers
                        if location == "Mundo" {
                            confirmed = global?["TotalConfirmed"] as? Int ?? 0
                            recovered = global?["TotalRecovered"] as? Int ?? 0
                            deaths = global?["TotalDeaths"] as? Int ?? 0
                            active = confirmed - deaths - recovered
                        } else {
                            for country in countries {
                                let slug = country["Slug"] as? String ?? ""
                                
                                if slug == location {
                                    confirmed = country["TotalConfirmed"] as? Int ?? 0
                                    recovered = country["TotalRecovered"] as? Int ?? 0
                                    deaths = country["TotalDeaths"] as? Int ?? 0
                                    active = confirmed - deaths - recovered
                                    break
                                }
                            }
                        }
                        
                        self.coronaStatistics = [confirmed, recovered, active, deaths]
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print(error)
                    self.coronaStatistics = [0,0,0,0]
                    
                }
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let labelHeight: CGFloat = 18
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 4,
                                          width: footerView.frame.size.width,
                                          height: labelHeight))
        label.textColor = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6470588235, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        
        switch section {
        case 2:
            label.text = "Última atualização: \(lastUpdated) \nFonte: Johns Hopkins University (CSSE)"
            label.sizeToFit()
        default:
            label.text = ""
        }
        
        footerView.addSubview(label)

        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0 && indexPath.section == 2) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VisaoGeralTableViewCell
            
            // Starting indicators
            cell.activesIndicator.startAnimating()
            cell.deathsIndicator.startAnimating()
            cell.recoveredIndicator.startAnimating()
            cell.confirmedIndicator.startAnimating()
            
            if (self.coronaStatistics != nil) {
                
                if self.coronaStatistics == [0,0,0,0] {
                    cell.confirmedNumber.text = ""
                    cell.recoveredNumber.text = ""
                    cell.activeNumber.text = ""
                    cell.deathsNumber.text = ""
                    
                } else {
                    cell.confirmedNumber.text = formatNumber(number: coronaStatistics[0])
                    cell.recoveredNumber.text = formatNumber(number: coronaStatistics[1])
                    cell.activeNumber.text = formatNumber(number: coronaStatistics[2])
                    cell.deathsNumber.text = formatNumber(number: coronaStatistics[3])
                    
                    // Stoping indicators
                    cell.activesIndicator.stopAnimating()
                    cell.deathsIndicator.stopAnimating()
                    cell.recoveredIndicator.stopAnimating()
                    cell.confirmedIndicator.stopAnimating()
                    cell.activesIndicator.hidesWhenStopped = true
                    cell.deathsIndicator.hidesWhenStopped = true
                    cell.recoveredIndicator.hidesWhenStopped = true
                    cell.confirmedIndicator.hidesWhenStopped = true
                }
                
            }
            
            return cell
            
        } else {
        
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            
            switch indexPath.section {
            case 0:
                let chevron = UIImage(named: "chevron-icon")
                cell.accessoryType = .disclosureIndicator
                cell.accessoryView = UIImageView(image: chevron!)
                self.countryIcon.image = self.country.image
                self.disclosureLabel.text = self.country.name
            default:
                break
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0 && indexPath.section == 0){

            if let viewController = storyboard?.instantiateViewController(identifier: "Filter") as? FilterTableViewController {
                viewController.delegate = self
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            return
        } else {
            updateGeneralData()
            chartView.zoom(scaleX: 0, scaleY: 0, x: 0, y: 0)
        }
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

// MARK: Date Formatter
extension Date {
    static func getFormattedDate(dateToFormat: String, originalFormat: String, newFormat:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = originalFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = newFormat

        let date: Date? = dateFormatterGet.date(from: dateToFormat)
        return dateFormatterPrint.string(from: date!);
    }
    
}

extension StatisticsTableViewController: selectedCountryProtocol{
    func setCountry(country: Country) {
        
        self.country = country
        navigationController?.popViewController(animated: true)
        self.tableView.reloadData()

    }
    
}
