//
//  StatisticsAPI.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 19/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import Foundation

class StatisticsAPI {
    // This class is used to simplify api
    // statistics api calls
    
    static func getCasesNumber() -> [Int] {
        
        var casesNumberArray: [Int] = [0]
        
        guard let url = URL(string: "https://covid19.mathdro.id/api/")
            
            else {
                print("Error while getting api url")
                return [0]
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
                            casesNumberArray = [deathsNumber, confirmedNumber, recoveredNumber, activeNumber]
                         }
                    }
                    
                } catch { print(error) }
            }
        }.resume()
        
        return casesNumberArray
    }

//    func dailyGlobalDeaths() -> [[Any]] {
//        var dailyDeath: [Int] = []
//        var days: [String] = []
//        
//        guard let url = URL(string: "https://covid19.mathdro.id/api/daily")
//            else {
//                print("Error while getting api url")
//                return [[0]]
//            }
//        
//        let session = URLSession.shared
//        
//        session.dataTask(with: url) { (data, response, error) in
//            
//            if let data = data {
//                
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        
//                        if let dailyData = json[""] as? [[String:Any]] {
//
//                            for data in dailyData {
//                                let deaths = data["deaths"] as? [String:Any]
//                                
//                                let deathsNumber = deaths?["total"] as? Int ?? 0
//                                let day = data["reportDate"] as? String ?? ""
//                                
//                                dailyDeath.append(deathsNumber)
//                                days.append(day)
//                            }
//                        }
//                        
//                    }
//                    
//                } catch { print(error) }
//            }
//        }.resume()
//        
//        return [days, dailyDeath]
//    }
    
    static func dailyGlobalConfirmed() -> [(x: String, y: Int)] {
        var result: [(x: String, y: Int)] = []
        
        guard let url = URL(string: "https://covid19.mathdro.id/api/daily")
            else {
                print("Error while getting api url")
                return result
            }
        
        let session = URLSession.shared
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        
                        for data in json {
                            let confirmed = data["confirmed"] as? [String:Any]

                            let confirmedNumber = confirmed?["total"] as? Int ?? 0
                            let day = data["reportDate"] as? String ?? ""
                            let value = (x: day, y: confirmedNumber)
                            
                            result.append(value)
                        }
                        
                    }
                    
                } catch { print(error) }
            }
        }).resume()
        
        return result
    }
}
