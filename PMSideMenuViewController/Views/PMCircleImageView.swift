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

    // MARK: - Properties
    // Public
    var imageBackgroundView : UIView!
    var imageView : UIImageView!

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear

        imageBackgroundView = UIView(frame: CGRect(x:0, y:0, width: frame.size.width - BORDER_WIDTH * 2, height: frame.size.height - BORDER_WIDTH * 2))
        imageBackgroundView.backgroundColor = .gray
        imageBackgroundView.layer.masksToBounds = true
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
        imageBackgroundView.layer.borderColor = UIColor.white.cgColor
        imageBackgroundView.layer.borderWidth = BORDER_WIDTH
        self.addSubview(imageBackgroundView)

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageBackgroundView.frame.size.width - BORDER_WIDTH * 3, height: imageBackgroundView.frame.size.height - BORDER_WIDTH * 3))
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = BORDER_WIDTH
        self.imageBackgroundView.addSubview(imageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageBackgroundView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        imageView.center = CGPoint(x: imageBackgroundView.frame.size.width / 2, y: imageBackgroundView.frame.size.height / 2)
    }

    //TODO: fixit
    //MARK : - Class Method
//    func setImage(url : String){
//        self.imageView.setImageUrl(url)
//    }
}
