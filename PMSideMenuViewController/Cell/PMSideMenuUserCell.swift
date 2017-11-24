//
//  PMSideMenuUserCell.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

private let LABEL_MARGIN : CGFloat = 5

class PMSideMenuUserCell: UITableViewCell {

    //MARK: - Property
    //Public
    var iconImageView : PMCircleImageView!
    var userNameLabel : UILabel!

    //MARK: - Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconImageView = PMCircleImageView(frame: CGRect(x:0, y:0, width:118, height:118))
        self.contentView.addSubview(iconImageView)

        userNameLabel = UILabel(frame: CGRect(x:0, y:iconImageView.frame.origin.y + iconImageView.frame.size.height, width: self.contentView.frame.size.width, height: 20))
        userNameLabel.backgroundColor = .clear
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNameLabel.textAlignment = .center
        self.contentView.addSubview(userNameLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.center = CGPoint(x: self.contentView.frame.size.width / 2, y: self.contentView.frame.size.height / 2)
        userNameLabel.frame = CGRect(x: 0, y: iconImageView.frame.origin.y + iconImageView.frame.size.height + LABEL_MARGIN, width: self.contentView.frame.size.width, height:20)
    }
}
