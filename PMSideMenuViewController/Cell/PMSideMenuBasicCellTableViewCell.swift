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
    var defaultColor : UIColor = .white
    var highlightedColor : UIColor = .white
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
        
        self.iconImageView = UIImageView(frame: .zero)
        self.iconImageView.backgroundColor = .clear
        self.contentView.addSubview(self.iconImageView)
        
        self.titleLabel = UILabel(frame: .zero)
        self.titleLabel.backgroundColor = .clear
        self.titleLabel.font = UIFont.systemFont(ofSize:17)
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var offsetX : CGFloat = 0.0
        
        if self.iconImageView.image != nil {
            self.iconImageView.frame = CGRect(x: LEFT_MARGIN, y: 0, width: self.contentView.frame.height, height: self.contentView.frame.height).insetBy(dx: CONTENT_MARGIN, dy: CONTENT_MARGIN)
            offsetX += self.iconImageView.frame.origin.x + self.iconImageView.frame.height
        }
        
        self.titleLabel.frame = CGRect(x: offsetX, y: 0, width: self.contentView.frame.width - offsetX, height: self.contentView.frame.height).insetBy(dx: CONTENT_MARGIN, dy: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            self.titleLabel.textColor = self.highlightedColor
            //TODO: fixit
//            if self.highlightedImage == nil {
//                self.highlightedImage = FLImageUtility.imageWithColor(self.defaultImage, color: self.highlightedColor)
//            }
            self.iconImageView.image = self.highlightedImage
        }else{
            self.updateAppearance()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Private Method
    private func updateAppearance() {
        if self.isCellSelected {
            self.titleLabel.textColor = self.highlightedColor
            //TODO: fixit
//            if self.highlightedImage == nil {
//                self.highlightedImage = FLImageUtility.imageWithColor(self.defaultImage, color: self.highlightedColor)
//            }
            self.iconImageView.image = self.highlightedImage
        }else{
            self.titleLabel.textColor = self.defaultColor
            self.iconImageView.image = self.defaultImage
        }
    }

}
