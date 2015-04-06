//
//  PMCircleImageView.swift
//  PMSideMenuView_Demo_swift
//
//  Created by Taku Inoue on 2015/04/06.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

private let BORDER_WIDTH : CGFloat = 3

class PMCircleImageView: UIView {

    // MARK : - Properties
    // Public
    var imageBackgroundView : UIView!
    var imageView : UIImageView!

    // MARK : - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()

        imageBackgroundView = UIView(frame: CGRectMake(0, 0, frame.size.width - BORDER_WIDTH * 2, frame.size.height - BORDER_WIDTH * 2))
        imageBackgroundView.backgroundColor = UIColor.grayColor()
        imageBackgroundView.layer.masksToBounds = true
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
        imageBackgroundView.layer.borderColor = UIColor.whiteColor().CGColor
        imageBackgroundView.layer.borderWidth = BORDER_WIDTH
        self.addSubview(imageBackgroundView)

        imageView = UIImageView(frame: CGRectMake(0, 0, imageBackgroundView.frame.size.width - BORDER_WIDTH * 3, imageBackgroundView.frame.size.height - BORDER_WIDTH * 3))
        imageView.backgroundColor = UIColor.clearColor()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.borderWidth = BORDER_WIDTH
        self.imageBackgroundView.addSubview(imageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageBackgroundView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        imageView.center = CGPointMake(imageBackgroundView.frame.size.width / 2, imageBackgroundView.frame.size.height / 2)
    }

    // MARK : - Class Method
    func setImage(image : UIImage?){
        if image != nil {
            self.imageView.image = image
        }
    }

}
