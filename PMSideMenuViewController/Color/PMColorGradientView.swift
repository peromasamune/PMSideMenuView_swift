//
//  PMColorGradientView.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMColorGradientView: UIView {

    // MARK: - Property
    // Public
    var gradientLayer : CAGradientLayer!

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = CGRect(x: 0, y:0, width: frame.width, height: frame.height)
        self.gradientLayer.colors = PMColorModel.getNearRandomColorsForGradient()
        self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    //MARK: - Public Method
    func reloadGradient() {
        self.gradientLayer?.colors = PMColorModel.getNearRandomColorsForGradient()
    }
}
