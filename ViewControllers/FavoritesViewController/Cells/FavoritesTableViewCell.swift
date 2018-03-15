//
//  FavoritesTableViewCell.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/14/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

protocol FavoritesTableViewCellDelegate {
    
    func tableButton(forCell: FavoritesTableViewCell)
}

class FavoritesTableViewCell: UITableViewCell {
    
    var eventTitle: UILabel!
    var eventImage: UIImageView!
    var createrImage: UIImageView!
    var createrUserName: UILabel!
    var date: UILabel!
    var interestedUserIds: UILabel!
    var delegate: FavoritesTableViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        eventImage = UIImageView(frame: CGRect(x: contentView.frame.minX + 10, y: contentView.frame.midY - 20, width: contentView.frame.width - 20, height: (contentView.frame.height / 2) - 10))
        eventTitle = UILabel(frame: CGRect(x: contentView.frame.minX + 10, y: contentView.frame.minY + 70, width: contentView.frame.width / 2, height: 20))
        createrImage = UIImageView(frame: CGRect(x: contentView.frame.minX + 10, y: contentView.frame.minY + 10, width: 50, height: 50))
        createrUserName = UILabel(frame: CGRect(x: contentView.frame.minX + 70, y: contentView.frame.minY + 25, width: contentView.frame.width / 2, height: 20))
        date = UILabel(frame: CGRect(x: contentView.frame.midX + 10, y: contentView.frame.minY + 70, width: contentView.frame.width / 2 + 25, height: 20))
        interestedUserIds = UILabel(frame: CGRect(x: contentView.frame.maxX - 120, y: contentView.frame.minY + 25, width: contentView.frame.width / 2 - 30, height: 20))
        eventTitle.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        eventTitle.textColor = .black
        createrUserName.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        createrUserName.textColor = .black
        date.textColor = .black
        interestedUserIds.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        interestedUserIds.textColor = .black
        eventImage.layoutIfNeeded()
        eventImage.layer.borderWidth = 1.0
        eventImage.layer.borderColor = UIColor.black.cgColor
        eventImage.layer.masksToBounds = true
        eventImage.layer.cornerRadius = 5
        eventImage.contentMode = .scaleAspectFill
        createrImage.layoutIfNeeded()
        createrImage.layer.borderWidth = 1.0
        createrImage.layer.borderColor = UIColor.black.cgColor
        createrImage.layer.masksToBounds = true
        createrImage.layer.cornerRadius = 5
        createrImage.contentMode = .scaleAspectFill
        // Initialization code
        contentView.addSubview(eventImage)
        contentView.addSubview(eventTitle)
        contentView.addSubview(createrUserName)
        contentView.addSubview(createrImage)
        contentView.addSubview(date)
        contentView.addSubview(interestedUserIds)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

