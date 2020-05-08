//
//  ChatbotController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 03/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ChatbotController: UIViewController{
    
    private let cellId = "cellId"
    
    var messages: [Message] = []
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        let session = URLSession.shared
        var question:String = inputTextField.text ?? ""
        
        //insert question to messages array
        let userQuestion = Message(text: question, date: NSDate(), isFromUser: true)
        self.messages.append(userQuestion)
        //insert message to chatlog
        let item = messages.count - 1
        let insertionIndexpath = IndexPath(item: item, section: 0)
        collectionView.insertItems(at: [insertionIndexpath])
        collectionView.scrollToItem(at: insertionIndexpath, at: .bottom, animated: true)
        
        inputTextField.text = nil
        
        //get bot response
        question = self.formatStringToURL(string: question)
        guard let url = URL(string: "https://oliver-fxdvmp.appspot.com/?question=\(question)")
            else {
                print("errorr")
                return
            }
        
        var retriedToAnswer = false
        
        session.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                var queriedString: [String] = []
                    
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // read out the bot response
                        if let fulfillmentMessages = json["fulfillmentMessages"] as? [[String:Any]] {
                            for message in fulfillmentMessages {
                                let textDict = message["text"] as? [String:Any]
                                let textValue = textDict?["text"] as? [Any]
                                let textString = textValue?[0] as? String
                                queriedString.append(textString ?? "")
                            }
                        }
                    }
                    
//                    //If the chat fails to get the answer the first time
//                    if queriedString.count == 1 && queriedString[0] == "" && retriedToAnswer == false {
//                        retriedToAnswer = true
//                        
//                        self.sendButtonPressed(self.sendButton)
//                    } else if queriedString.count == 1 && queriedString[0] == "" && retriedToAnswer == true {
//                        let answer = "Desculpe, não consegui obter a resposta. Você poderia reformular a pergunta?"
//                        queriedString[0] = answer
//                    }
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    retriedToAnswer = false
                    //insert answer to messages array
                    for answer in queriedString {
                        let botAnswer = Message(text: answer, date: NSDate(), isFromUser: false)
                        self.messages.append(botAnswer)
                        
                        //insert answer to chatlog
                        let item = self.messages.count - 1
                        let insertionIndexpath = IndexPath(item: item, section: 0)
                        self.collectionView.insertItems(at: [insertionIndexpath])
                        self.collectionView.scrollToItem(at: insertionIndexpath, at: .bottom, animated: true)
                    }
                    
                }
            }
        }).resume()

    }
    
    func formatStringToURL(string: String) -> String {
        // Formats string to a URL standard
        
        let formatedString:String = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        return formatedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Chatbot"
        
        setUpTextField()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
                   
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setUpTextField(){
        inputTextField.layer.cornerRadius = 18
        inputTextField.layer.borderWidth = 0.8
        inputTextField.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.00).cgColor
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Faça uma pergunta ao bot",attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.00)])
    }
    
    @objc func handleKeyBoardNotification(notification: NSNotification){
        
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint.constant = isKeyboardShowing ? -keyboardFrame!.height + (tabBarController?.tabBar.frame.height)! : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
                //scroll collection view up to show last message when keyboard is showing
                if isKeyboardShowing{
                    let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
}

extension ChatbotController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //use safe unwrap when using with message model
        let messageText = messages[indexPath.item].text
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        //calculates frame size based on text
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

        return CGSize(width: view.frame.width, height: estimatedFrame.height+20)
        //default return when using safe unwrap
//        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        let message = messages[indexPath.item]

        cell.messageTextView.text = message.text

        //use safe unwrap when using with message model
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        //calculates frame size based on text
        let estimatedFrame = NSString(string: message.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

        if message.isFromUser == false{
            cell.messageTextView.frame = CGRect(x: 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: 8 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
            cell.messageTextView.textColor = UIColor.white
            cell.bubbleImageView.image = MessageCell.leftBubbleImage
            cell.bubbleImageView.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)

        } else{
            cell.messageTextView.frame = CGRect(x: view.frame.width -  estimatedFrame.width - 16 - 8 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: view.frame.width -  estimatedFrame.width - 16 - 16 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
            cell.messageTextView.textColor = UIColor.white
            cell.bubbleImageView.image = MessageCell.rightBubbleImage
            cell.bubbleImageView.tintColor = UIColor(red: 0.68, green: 0.03, blue: 0.16, alpha: 1.00)
        }
        
        return cell
    }
}
