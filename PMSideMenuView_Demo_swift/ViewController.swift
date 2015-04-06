//
//  ViewController.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class ViewController: PMSideMenuBaseViewController {

    var titleLabel : UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        titleLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 40))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
        titleLabel.text = self.title
        self.view.addSubview(titleLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

