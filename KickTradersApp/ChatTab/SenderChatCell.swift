//
//  SenderChatCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SenderChatCell: UITableViewCell {



    var bgView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()



    var textView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()


    var bottomLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()



    let extraSpacing: CGFloat = 80

    let innerSpacing: CGFloat = 4

    let padding: CGFloat = 16

    let secondaryPadding: CGFloat = 8

    var textviewTopConstraintToBg: NSLayoutConstraint!

    var textviewTopConstraintToTopLabel: NSLayoutConstraint!



    @IBOutlet var lblSenderTextMessage: UILabel!
    @IBOutlet var lblSenderDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



    func setupSendersCell()
    {
        let offset = UIEdgeInsets(top: padding, left: padding, bottom: -padding, right: -padding)
        self.contentView.addSubview(bgView)
        bgView.edges([.right, .top, .bottom], to: self.contentView, offset: offset)
        bgView.layer.cornerRadius = 8
        bgView.backgroundColor = UIColor(displayP3Red: 0, green: 122/255, blue: 255/255, alpha: 1)

        self.bgView.addSubview(textView)
        textView.edges([.left, .right, .top], to: self.bgView, offset: .init(top: innerSpacing, left: innerSpacing, bottom: -innerSpacing, right: -innerSpacing))
        bgView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: extraSpacing).isActive = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear

        self.bgView.addSubview(bottomLabel)
        bottomLabel.edges([.left, .bottom], to: self.bgView, offset: UIEdgeInsets(top: innerSpacing, left: secondaryPadding, bottom: -secondaryPadding, right: 0))
        bottomLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -secondaryPadding).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: -2).isActive = true
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        bottomLabel.textColor = UIColor.white
        bottomLabel.textAlignment = .right

    }


    
}




