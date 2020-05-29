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
                            casesNumberArray = [confirmedNumber, recoveredNumber, activeNumber, deathsNumber]
                         }
                    }
                    
                } catch { print(error) }
            }
        }.resume()
        
        return casesNumberArray
    }
}
