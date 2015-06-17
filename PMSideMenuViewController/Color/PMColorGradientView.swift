//
//  PMColorGradientView.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMColorGradientView: UIView {

    // MARK : - Property
    // Public
    var gradientLayer : CAGradientLayer?

    // MARK : - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.gradientLayer = CAGradientLayer()
        self.gradientLayer?.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))
        self.gradientLayer?.colors = PMColorModel.getNearRandomColorsForGradient() as [AnyObject]
        self.gradientLayer?.startPoint = CGPointMake(0.5, 0.0)
        self.gradientLayer?.endPoint = CGPointMake(0.5, 1.0)

        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.gradientLayer?.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
    }

}
