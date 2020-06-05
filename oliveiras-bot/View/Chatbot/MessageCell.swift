//
//  MessageCell.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 06/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

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
    
    let typingIndicatorView = TypingBubble()

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
