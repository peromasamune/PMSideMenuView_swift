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

    //MARK : - Property
    //Public
    var iconImageView : PMCircleImageView!
    var userNameLabel : UILabel!

    //MARK : - Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconImageView = PMCircleImageView(frame: CGRectMake(0, 0, 118, 118))
        self.contentView.addSubview(iconImageView)

        userNameLabel = UILabel(frame: CGRectMake(0, iconImageView.frame.origin.y + iconImageView.frame.size.height, self.contentView.frame.size.width, 20))
        userNameLabel.backgroundColor = UIColor.clearColor()
        userNameLabel.font = UIFont.boldSystemFontOfSize(15)
        userNameLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(userNameLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        iconImageView.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2)
        userNameLabel.frame = CGRectMake(0, iconImageView.frame.origin.y + iconImageView.frame.size.height + LABEL_MARGIN, self.contentView.frame.size.width, 20)
    }

}
