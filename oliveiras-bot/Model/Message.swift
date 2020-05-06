//
//  Message.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 06/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import Foundation

class Message {
    
    let text: String
    let date: NSDate
    let isFromUser: Bool
    
    // Standard init
    init(text: String, date: NSDate, isFromUser: Bool) {
        self.text = text
        self.date = date
        self.isFromUser = isFromUser
    }
    
}
