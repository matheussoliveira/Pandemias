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
    private let typingIndicadorId = "typingIndicator"
    
    var messages: [Message] = []
    var isTyping: Bool = false
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        let question:String = inputTextField.text ?? ""
        
        ///checks if user input is not empty or only whitespaces
        if !question.trimmingCharacters(in: .whitespaces).isEmpty {
            //insert question to messages array
            let userQuestion = Message(text: question, date: NSDate(), isFromUser: true)
            self.messages.append(userQuestion)
            //insert user message to chatlog
            var item = messages.count - 1
            var insertionIndexpath = IndexPath(item: item, section: 0)
            collectionView.insertItems(at: [insertionIndexpath])
            collectionView.scrollToItem(at: insertionIndexpath, at: .bottom, animated: true)
            
            inputTextField.text = nil
            
            //insert question to messages array
            let loadingState = Message(text: "...", date: NSDate(), isFromUser: false)
            self.messages.append(loadingState)
            //insert user message to chatlog
            item = messages.count - 1
            insertionIndexpath = IndexPath(item: item, section: 0)
            collectionView.insertItems(at: [insertionIndexpath])
            collectionView.scrollToItem(at: insertionIndexpath, at: .bottom, animated: true)
            
            getBotResponse(question: question)
        }

    }
    
    func getBotResponse(question: String){
        
        let session = URLSession.shared

        //access url to get response
        let questionURL = self.formatStringToURL(string: question)
        guard let url = URL(string: "https://oliver-fxdvmp.appspot.com/?question=\(questionURL)")
            else {
                print("errorr")
                return
            }

        var retriedToAnswer = false

        //get response
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

                    //If the chat fails to get the answer the first time
                    if queriedString.count == 1 && queriedString[0] == "" && retriedToAnswer == false {
                        retriedToAnswer = true

                        self.getBotResponse(question: question)
                    } else
                    if queriedString.count == 1 && queriedString[0] == "" && retriedToAnswer == true {
                        let answer = "Desculpe, não consegui obter a resposta. Você poderia reformular a pergunta?"
                        queriedString[0] = answer
                    }

                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }

                DispatchQueue.main.async {
                    
                    if self.messages[self.messages.count-1].text == "..."{
                        self.messages.removeLast()
                        let item = self.messages.count
                        let insertionIndexpath = IndexPath(item: item, section: 0)
                        self.collectionView.deleteItems(at: [insertionIndexpath])
                    }
                    
                    retriedToAnswer = false
                    //insert answer to messages array
                    for answer in queriedString {
                        if answer != ""{
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TypingBubbleCell.self, forCellWithReuseIdentifier: typingIndicadorId)
                   
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupWelcomeMessage()
        setUpTextField()
        setupHideKeyboardOnTap()
    }
    
    func setupWelcomeMessage(){
        let welcomeMessage = Message(text: "Olá! Eu sou a June, do Pandemias, e estou aqui para te ajudar tirando suas dúvidas e dando dicas sobre o Coronavírus (COVID - 19).",
                                     date: NSDate(), isFromUser: false)
        let tipsMessage = Message(text: "Posso te ajudar a responder perguntas como: \n\n • Quais as estatísticas para o Brasil? \n • Posso usar máscara de pano? \n • Quantos casos ativos em São Paulo? \n • Quantos recuperados nas últimas 24 horas no Brasil? \n\n Entre outras.",
                                     date: NSDate(), isFromUser: false)
        self.messages.append(welcomeMessage)
        self.messages.append(tipsMessage)
        let item = messages.count - 2
        let insertionIndexpath = IndexPath(item: item, section: 0)
        collectionView.insertItems(at: [insertionIndexpath])
    }
    
    func setUpTextField(){
        // Setup bot icon and name
        
        self.containerView.layer.borderWidth = 0.8
        self.containerView.layer.borderColor = UIColor.white.cgColor
        self.containerView.layer.cornerRadius = 22
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Faça uma pergunta à June",attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.00)])
    }
    
    @objc func handleKeyBoardNotification(notification: NSNotification){
        
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            if isKeyboardShowing{
                bottomConstraint.constant = -keyboardFrame!.height - 17 +   (UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
            } else {
                bottomConstraint.constant = -6
            }
            
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
        if self.isTyping == false{
            return messages.count
        } else {
            return messages.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.isTyping == false{
            //use safe unwrap when using with message model
            let messageText = messages[indexPath.item].text
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //calculates frame size based on text
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

            return CGSize(width: view.frame.width, height: estimatedFrame.height+20)
        } else{
        //default return when using safe unwrap
            return CGSize(width: view.frame.width, height: 35)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isTyping == false{
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
                cell.bubbleImageView.tintColor = UIColor(red: 0.68, green: 0.03, blue: 0.16, alpha: 1.00)

            } else{
                cell.messageTextView.frame = CGRect(x: view.frame.width -  estimatedFrame.width - 16 - 8 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: view.frame.width -  estimatedFrame.width - 16 - 16 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                cell.messageTextView.textColor = UIColor.white
                cell.bubbleImageView.image = MessageCell.rightBubbleImage
                cell.bubbleImageView.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)

            }
            return cell
        } else {
            //display typing indicator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
            cell.addSubview(cell.typingIndicatorView)
            cell.typingIndicatorView.startAnimating()

            return cell
        }
    }
}

extension ChatbotController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.collectionView.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
