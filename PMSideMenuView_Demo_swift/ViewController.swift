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
        titleLabel = UILabel(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:40))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.center = CGPoint(x: self.view.frame.size.width / 2, y:self.view.frame.size.height / 2)
        titleLabel.text = self.title
        self.view.addSubview(titleLabel)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(menuButtonDidPush(sender:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func menuButtonDidPush(sender : AnyObject?) {
        self.sideMenu?.toggleSideMenu()
    }
}

