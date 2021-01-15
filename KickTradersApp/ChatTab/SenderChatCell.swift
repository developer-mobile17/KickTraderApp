//
//  SenderChatCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SenderChatCell: UITableViewCell {



    let bubbleView: ChatBubbleView = {
        let v = ChatBubbleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var leadingOrTrailingConstraint = NSLayoutConstraint()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() -> Void {

        // add the bubble view
        contentView.addSubview(bubbleView)

        // constrain top / bottom with 12-pts padding
        // constrain width to lessThanOrEqualTo 2/3rds (66%) of the width of the cell
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.66),
            ])

    }




    func setData(_ message: ChatHistory) -> Void {

            // set the label text
           // bubbleView.chatLabel.text = message.message

            // tell the bubble view whether it's an incoming or outgoing message
         //  bubbleView.incoming = (message.message != nil)

            // left- or right-align the bubble view, based on incoming or outgoing
            leadingOrTrailingConstraint.isActive = false
        if message.userType == "Buyer" {
            bubbleView.chatLabel.text = message.message
                leadingOrTrailingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
            } else {
                leadingOrTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
            }
            leadingOrTrailingConstraint.isActive = true
        }



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
    
}


