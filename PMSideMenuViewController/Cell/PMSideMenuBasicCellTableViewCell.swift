//
//  PMSideMenuBasicCellTableViewCell.swift
//  FindLunch
//
//  Created by Peromasamune on 2015/08/24.
//  Copyright (c) 2015年 Peromasamune. All rights reserved.
//

import UIKit

private let LEFT_MARGIN : CGFloat = 5
private let CONTENT_MARGIN : CGFloat = 5.0

class PMSideMenuBasicCellTableViewCell: UITableViewCell {

    //MARK: - Properties
    //MARK: Public
    var iconImageView : UIImageView!
    var titleLabel : UILabel!
    var defaultColor : UIColor = UIColor.whiteColor()
    var highlightedColor : UIColor = UIColor.whiteColor()
    var isCellSelected : Bool = false {
        didSet{
            self.updateAppearance()
        }
    }
    var defaultImage : UIImage? {
        didSet{
            if defaultImage != nil {
                self.iconImageView.image = defaultImage
            }
        }
    }
    var highlightedImage : UIImage?
    
    //MARK: Private
    
    //MARK: - Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.iconImageView = UIImageView(frame: CGRectZero)
        self.iconImageView.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.iconImageView)
        
        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.font = UIFont.systemFontOfSize(17)
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var offsetX : CGFloat = 0.0
        
        if self.iconImageView.image != nil {
            self.iconImageView.frame = CGRectInset(CGRectMake(LEFT_MARGIN, 0, CGRectGetHeight(self.contentView.frame), CGRectGetHeight(self.contentView.frame)), CONTENT_MARGIN, CONTENT_MARGIN)
            offsetX += self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.frame)
        }
        
        self.titleLabel.frame = CGRectInset(CGRectMake(offsetX, 0, CGRectGetWidth(self.contentView.frame) - offsetX, CGRectGetHeight(self.contentView.frame)), CONTENT_MARGIN, 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            self.titleLabel.textColor = self.highlightedColor
            if self.highlightedImage == nil {
                self.highlightedImage = FLImageUtility.imageWithColor(self.defaultImage, color: self.highlightedColor)
            }
            self.iconImageView.image = self.highlightedImage
        }else{
            self.updateAppearance()
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Private Method
    private func updateAppearance() {
        if self.isCellSelected {
            self.titleLabel.textColor = self.highlightedColor
            if self.highlightedImage == nil {
                self.highlightedImage = FLImageUtility.imageWithColor(self.defaultImage, color: self.highlightedColor)
            }
            self.iconImageView.image = self.highlightedImage
        }else{
            self.titleLabel.textColor = self.defaultColor
            self.iconImageView.image = self.defaultImage
        }
    }

}
