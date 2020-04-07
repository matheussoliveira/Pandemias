//
//  ViewController.swift
//  oliveiras-bot
//
//  Created by Matheus Oliveira on 30/03/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit
import ApiAI

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var answer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sendMessage(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
            
        if let text = self.textField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            
            if let response = response as? AIResponse {
                if response.result.fulfillment.speech != nil {
                    self.answer.text = response.result.fulfillment.speech
                }
            }
            
            }, failure: { (request, error) in
                print(error!)
            })
            
        ApiAI.shared().enqueue(request)
        self.clearTextField()
    }
    
    private func clearTextField() {
        // Clears message text field
        
        self.textField.text = ""
    }
}

