//
//  ChatbotController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 03/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class ChatbotController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    let messages = ["Oi, tudo bem?"
        , "Olá, quantos casos no Brasil?",
          "54.000 casos ativos",
          "Quantas mortes no Brasil?",
          "7300 óbitos"]
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        let session = URLSession.shared
        var question:String = inputTextField.text ?? ""
        question = self.formatStringToURL(string: question)
        guard let url = URL(string: "https://oliver-fxdvmp.appspot.com/?question=\(question)")
            else {
                print("errorr")
                return
            }
        
        session.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                let queriedString:String = String(data: data, encoding: String.Encoding.utf8) ?? ""
                DispatchQueue.main.async {
                    print(queriedString)
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        overrideUserInterfaceStyle = .dark

        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
                   
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true

        self.navigationController!.navigationBar.tintColor = UIColor.black


    }

//    override func viewWillAppear(_ animated: Bool) {
//
//        self.tabBarController?.navigationItem.title = "Chatbot"
//
//    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell

        cell.messageTextView.text = messages[indexPath.item]

        //use safe unwrap when using with message model
        let messageText = messages[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        //calculates frame size based on text
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

        if indexPath.item % 2 == 0{
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //use safe unwrap when using with message model
        let messageText = messages[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        //calculates frame size based on text
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

        return CGSize(width: view.frame.width, height: estimatedFrame.height+20)
        //default return when using safe unwrap
//        return CGSize(width: view.frame.width, height: 100)
    }
    
}

class MessageCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let textBubbleView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    static let leftBubbleImage = UIImage(named: "bubble_left")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    static let rightBubbleImage = UIImage(named: "bubble_right")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = MessageCell.leftBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()

    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.text = "Sample Message"
        textView.isEditable = false
        return textView
    }()

    func setUpViews(){

        addSubview(textBubbleView)
        addSubview(messageTextView)
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintWithFormat("H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintWithFormat("V:|[v0]|", views: bubbleImageView)

    }
}

extension UIView{
func addConstraintWithFormat(_ format : String, views : UIView...) {

    var viewsDictionary = [String : UIView]()

    for(index, view) in views.enumerated(){
        let key = "v\(index)"
        view.translatesAutoresizingMaskIntoConstraints = false
        viewsDictionary[key] = view
    }
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))

    }
}
