//
//  ReceiverChatCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ReceiverChatCell: UITableViewCell {



    var bgViewR: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()



    var textViewR: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()


    var bottomLabelR: UILabel = {
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






    @IBOutlet var lblReceiverTextMessage: UILabel!
    @IBOutlet var imgReceiverChat: UIImageView!
    
    @IBOutlet var lblReceiverDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setupReceiverCell()
    {
        let offset = UIEdgeInsets(top: padding, left: padding, bottom: -padding, right: -padding)
        self.contentView.addSubview(bgViewR)
        bgViewR.edges([.right, .top, .bottom], to: self.contentView, offset: offset)
        bgViewR.layer.cornerRadius = 8
        bgViewR.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)

        self.bgViewR.addSubview(textViewR)
        textViewR.edges([.left, .right, .top], to: self.bgViewR, offset: .init(top: innerSpacing, left: innerSpacing, bottom: -innerSpacing, right: -innerSpacing))
        bgViewR.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: extraSpacing).isActive = true
        textViewR.isScrollEnabled = false
        textViewR.isEditable = false
        textViewR.isSelectable = true
        textViewR.font = UIFont.systemFont(ofSize: 14)
        textViewR.textColor = UIColor.white
        textViewR.backgroundColor = UIColor.clear

        self.bgViewR.addSubview(bottomLabelR)
        bottomLabelR.edges([.left, .bottom], to: self.bgViewR, offset: UIEdgeInsets(top: innerSpacing, left: secondaryPadding, bottom: -secondaryPadding, right: 0))
        bottomLabelR.trailingAnchor.constraint(equalTo: textViewR.trailingAnchor, constant: -secondaryPadding).isActive = true
        bottomLabelR.topAnchor.constraint(equalTo: textViewR.bottomAnchor, constant: -2).isActive = true
        bottomLabelR.font = UIFont.systemFont(ofSize: 10)
        bottomLabelR.textColor = UIColor.white
        bottomLabelR.textAlignment = .right

    }
    
}
